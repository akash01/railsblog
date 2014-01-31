class UsersController < ApplicationController

  before_action :confirm_logged_in, only: [:index,:show,:edit,:update]
  before_action :current_user
  before_action :user_edit, only: [:edit,:update]

  def index
    #@users = User.newest_first
    if @current_user.role == 1
      @users = User.newest_first  
    else
      redirect_to :admin
    end
  end

  def show
    redirect_to :admin
  	#@user = User.find(params[:id])
  end

  def new
    if (@current_user.present? && current_user.role == 1) || @current_user.blank?
      @user = User.new
    else
      redirect_to :admin, :notice => "U are already logged in ."
    end
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
    #@user = User.find(params[:id])
  end

  def update
  	#@user = User.find(params[:id])
  	if @user.update_attributes(user_params)
  		flash[:notice] = @user.firstname + " updated successfully"
  		redirect_to(:action => "index")
  	else
  		redirect_to :admin, :notice => "Error editing form"
  	end
  end

  def destroy
  	@user = User.find(params[:id]).destroy
  	redirect_to :back, :notice =>  "Deleted " + @user.firstname + "successfully" 
  end

  def contact
    
  end

  private
  	def user_params
  		params.require(:user).permit(:firstname,:lastname,:email,:password,:password_confirmation,:role)
  	end

    def user_edit
      if @current_user.role == 1
        @user = User.find(params[:id])  
      else
        @user = User.where(:id => @current_user.id).find_by_id(params[:id])
        redirect_to("/admin", :notice => 'U dont have previledge to edit other users') unless @user
      end
    end
end
