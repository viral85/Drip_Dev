class User < ActiveRecord::Base
  ActiveRecord::Base.send(:include, ActiveModel::ForbiddenAttributesProtection)
  has_many :emails

  attr_accessor :password

  #attr_accessible :name,:email,:password, :password_confirmation
  #attr_accessible Replaced by Strong Parameters 

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,    :presence => true,
                      :length => {:maximum => 50}
  
  validates :email,   :presence => true,
                      :format => {:with => email_regex},
                      :uniqueness => {:case_sensitive => false}

  validates :password,:presence=> true,
                      :confirmation => true,
                      :length => {:within => 6..40}

  before_save :encrypt_password
 
  def has_password?(submitted_password)
  	password_hash == encrypt(submitted_password) 
  end

class << self
	   def authenticate(email,submitted_password)
	    	user = find_by_email(email)
	    	(user && user.has_password?(submitted_password)) ? user: nil
	   end
   
	   def authenticate_with_salt(id,cookie_salt)
	   	  	user = find_by_id(id)
	    	(user && user.password_salt == cookie_salt) ? user : nil
	   end
   
   end

  private 

	  def encrypt_password
	  	self.password_salt = make_salt if new_record?
	  	self.password_hash = encrypt(password)
	  end

	  def encrypt(string)
	  	secure_hash("#{password_salt}--#{string}")
	  end

	  def make_salt
	  	secure_hash("#{Time.now.utc}--#{password}")
	  end

	  def secure_hash(string)
	  	Digest::SHA2.hexdigest(string)
	  end


end
