class User < ActiveRecord::Base

	has_many :posts , :dependent => :destroy

	ROLE_ADMIN = 1
	has_secure_password

	scope :sorted, lambda { order("users.created_at ASC") }
	scope :newest_first, lambda { order("users.created_at DESC") }
	scope :admin, lambda { where( :role => ROLE_ADMIN ) }
	#scope :loggeduser, lambda { where(:id => session[:user_id]) }

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
	validates :firstname, :presence => true, :length => { :within => 2..50 }
	validates :lastname, :presence => true, :length => { :within => 2..50 }
	validates :email, :presence => true, :uniqueness => true, :length => { :within => 4..100 },format: { with: EMAIL_REGEX  }

end
