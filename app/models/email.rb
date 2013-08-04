class Email < ActiveRecord::Base
  belongs_to :user
  #attr_accessible :from_name,:from_email,:to_email,:subject,:text_body,:user_id,:html_body,:is_published
  #attr_accessible Replaced by Strong Parameters 
   email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  validates :from_email,   :presence => true,
                      :format => {:with => email_regex}
                     

  validates :to_email, :presence => true,
                      :format => {:with => email_regex}
                     

                      

end
