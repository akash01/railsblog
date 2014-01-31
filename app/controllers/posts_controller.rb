class PostsController < ApplicationController
  
  before_action :confirm_logged_in, only: [:postslist,:new,:create,:edit,:update]
  before_action :all_posts
  before_action :find_post, only: [:show]
  before_action :current_user
  before_action :user_posts, only: [:edit,:update]
  

  def index
  	#@posts = Post.sorted
  end

  def postslist
    if @current_user.role == 1
      @posts = Post.newest_first  
    else
      @posts = Post.where(:user_id => @current_user.id )
    end
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
      redirect_to :allposts
    else
      render('new')
    end
  end

  def edit
    
  end

  def update
    #@post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_path, :notice => 'Your posts was successfully updated'
    else
      redirect_to :admin, :notice => 'There was an error updating your post.'
    end
  end

  def destroy
  	@post = Post.find(params[:id]).destroy
  	redirect_to :back, :notice => "Deleted " + @post.title + " successfully" 
  end

  private
  	def all_posts
  		#@posts = Post.newest_first
      @posts = Post.paginate(:page => params[:page], :per_page => 5).newest_first
  	end

    def user_posts
      if @current_user.role == 1
        @post = Post.find(params[:id])  
      else
        @post = Post.where(:user_id => @current_user.id).find_by_id(params[:id])
        redirect_to("/admin", :notice => 'Record not found') unless @post
      end
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
