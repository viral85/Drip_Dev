require 'spec_helper'

describe Email do
  before(:each) do
          @attr = {
              :from_name => "Example User",
              :from_email => "user@example.com",
              :to_email => "user2@example.com",
              :subject => "unit_test",
              :text_body => "abc xyz"
                  }
  end
   
    it "should belongs to user" do
      should belong_to :user 
    end
    
    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
         valid_email_user = Email.new(@attr.merge(:from_email => address))
         valid_email_user.should be_valid
      end
    end
    
    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
         valid_email_user = Email.new(@attr.merge(:to_email => address))
         valid_email_user.should be_valid
      end
    end
    
end