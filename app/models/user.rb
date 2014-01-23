class User < ActiveRecord::Base

	has_many :posts , :dependent => :destroy

	has_secure_password

	scope :sorted, lambda { order("users.created_at ASC") }
	scope :newest_first, lambda { order("users.created_at DESC") }
end
