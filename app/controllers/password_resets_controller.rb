class PasswordResetsController < ApplicationController

	def new
	end

	def create
		@user=User.find_by(email: params[:email])
		if @user
			@user.create_reset_digest
			# flash[:notice]="reset_digest is in database"
			UserMailer.password_reset(@user)
			flash[:notice]="Email sent with password reset intsructions"
			redirect_to root_url
		else
			flash.now[:failure]="Email address not found"
			render :new
		end
	end

	def edit
	end

end
