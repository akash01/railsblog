class UsersController < ApplicationController

  def index
  	#@posts = Post.sorted
    @posts = Post.where(:user_id => @current_user.id )
  end

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:notice] = @user.firstname + " User created successfully"
      	redirect_to(:action => 'index')
  	else
  		render('new')
  	end
  end

  def edit
  	@user = User.find(params[:id])
  	if @user.update_attributes(user_params)
  		flash[:notice] = @user.firstname + " updated successfully"
  		redirect_to(:action => "index")
  	else
  		redirect_to :back, :notice => "Error editing form"
  	end
  end

  def destroy
  	@user = User.find(params[:id]).destroy
  	redirect_to :back, :notice =>  "Deleted " + @user.firstname + "successfully" 
  end

  private
  	def user_params
  		params.require(:user).permit(:firstname,:lastname,:email,:password,:password_confirmation)
  	end
end
