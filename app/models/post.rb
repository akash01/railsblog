class Post < ActiveRecord::Base

	#belongs_to :user
	belongs_to :author, :class_name => "User" , :foreign_key => "user_id"

	scope :sorted, lambda { order("posts.created_at ASC") }
	scope :newest_first, lambda { order("posts.created_at DESC") }

end
