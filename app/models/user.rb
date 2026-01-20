class User <  ApplicationRecord
  before_save :downcase_email
  has_many :articles
  validates :username, presence: true, 
                      uniqueness: { case_sensitive: false }, 
                      length: {minimum: 3, maximum: 25}

  #uniqueness will check for the value to be unique it will not check for case sensitiity
  #i.e 'a' and 'A' are not similar. To avoid This,
  #uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #this is a constant in ruby all caps is used for const

  validates :email, presence: true,
                  uniqueness: { case_sensitive: false }, 
                  length: {maximum: 105},
                  format: { with: VALID_EMAIL_REGEX }
  
  has_secure_password

private

  def downcase_email
    self.email = self.email.downcase
  end

end

