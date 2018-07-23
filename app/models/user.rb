class User < ActiveRecord::Base

    has_secure_password
    before_validation :downcase_email

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, :password_confirmation, length: { minimum: 8 }

    private

    def downcase_email
      self.email = email.downcase if email.present?
    end

end
