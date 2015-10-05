class SessionsController < ApplicationController

	def new
	end

	def create
		@user = User.find_by_email(params[:email])
		if @user && @user.authenticate(params[:password_digest])
			sign_in(@user)
			flash[:success] = "Signed in successfully!"
			redirect_to user_profile_path(@user.id)
		else 
			flash[:error] = "Unable to sign in."
			redirect_to root_path
		end
	end

	def destroy 
		sign_out
		flash[:success] = "Signed out successfully"
		redirect_to root_path
	end


end
