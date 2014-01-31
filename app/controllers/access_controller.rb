class AccessController < ApplicationController

	before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]
	before_action :current_user

	def index
	end

	def login
		#login form
		@user = User.new
	end

	def attempt_login
		if params[:user][:email].present? && params[:user][:password].present?
			found_user = User.where(:email => params[:user][:email]).first
			if found_user
				authorize_user = found_user.authenticate(params[:user][:password])
			end
		end
		if authorize_user
			session[:user_id] = authorize_user.id
			session[:firstname] = authorize_user.firstname
			flash[:notice] = "You are now logged in"
			redirect_to(:action => 'index')
		else
			flash[:notice] = "Invalid username/password."
			redirect_to(:action => "login")
		end
	end

	def logout
		session[:user_id] = nil
		session[:firstname] = nil
		flash[:notice] = "Logout successful"
		redirect_to(:action => "login")
	end

end
