class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence:true
  validates :last_name, presence:true
  validates :email, uniqueness: {case_sensitive: false, message:"already registered"}, presence:true 
  validates :password, presence:true, confirmation:true, length: {minimum: 5}
  validates :password_confirmation, presence:true

  before_save do self.email.downcase! end
  

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    
    # If the user does not exist or does not authenticate
    if !user || !user.authenticate(password)
      user = nil
    end

    return user
  end

end
