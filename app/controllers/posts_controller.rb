class PostsController < ApplicationController
  
  before_action :all_posts
  before_action :find_post, only: [:show,:edit,:update]

  def index
  	#@posts = Post.sorted
  end

  def show
  	#@post = Post.find(params[:id])
  	#@posts = Post.sorted
  end

  def new
  	@post = Post.new(post_params)
  end

  def create
  	@post = Post.new(post_params) 
    if @post.save
      flash[:notice] = "Post created successfully"
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
  end

  def update
    #@post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to posts_path, :notice => 'Your posts was successfully updated'
    else
      redirect_to :back, :notice => 'There was an error updating your post.'
    end
  end

  def destroy
  	@post = Post.find(params[:id]).destroy
  	redirect_to :back, :notice => "Deleted " + @post.title + " successfully" 
  end

  private
  	def all_posts
  		@posts = Post.sorted
  	end

  	def find_post
  		@post = Post.find(params[:id])
  	end

  	def post_params
  		if params[:post].present?
  			params.require(:post).permit(:title,:body,:user_id)
  		end
  	end
end
