class User < ApplicationRecord
	has_secure_password
	validates :username, :email, :password, presence: true
	validates :username, :email, uniqueness: true
	validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
	has_many :trips, dependent: :destroy
	has_one_attached :profile_pic
end
