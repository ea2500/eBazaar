class User < ActiveRecord::Base

	attr_accessor :dummy_token, :activation_token, :reset_pswd_token

	has_many :products, dependent: :destroy

	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
	                format: { with: VALID_EMAIL_REGEX },
	                uniqueness: { case_sensitive: false }
	
	validates :password, presence: true, length: { minimum: 6 }
	has_secure_password

	def reset_dummy_token
		@dummy_token=SecureRandom.urlsafe_base64
		dummy_digest=BCrypt::Password.create(@dummy_token)
		self.update_attribute(:dummy, dummy_digest)
		return @dummy_token
	end

	def set_activation_digest
		@activation_token=SecureRandom.urlsafe_base64
		activation_digest=BCrypt::Password.create(@activation_token)
		self.update_attribute(:activation_digest, activation_digest)
	end

	def create_reset_digest
		@reset_pswd_token=SecureRandom.urlsafe_base64
		reset_password_digest=BCrypt::Password.create(@reset_pswd_token)
		self.update_attribute(:reset_digest, reset_password_digest)
		self.update_attribute(:reset_sent_at, Time.zone.now)
	end

end
