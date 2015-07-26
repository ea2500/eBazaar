class PasswordResetsController < ApplicationController
	before_action :bounce_logged_in_user
	before_action :bounce_unauthorized_or_expired_token, only: [:edit, :update]

	def new
	end

	def create
		@user=User.find_by(email: params[:email].downcase)
		if @user
			@user.create_reset_digest
			# flash[:notice]="reset_digest is in database"
			UserMailer.password_reset(@user).deliver
			flash[:notice]="Email sent with password reset intsructions"
			redirect_to root_url
		else
			flash.now[:failure]="Email address not found"
			render :new
		end
	end

	def edit
	end

	def update
		if params[:user][:password].blank?
			flas.now[:failure]='! ! ! Password can not be blank...'
			render :edit
		elsif @user.update_attributes(user_params)
			log_user_in(@user)
			flash[:success] = "Password has been reset and you logged in..."
			redirect_to @user
		else
			render :edit
		end
		
	end


	private
		
		def user_params
			params.require(:user).permit(:password, :password_confirmation)
		end

		def bounce_unauthorized_or_expired_token
			# passed from email link
			# params[:id] carries the reset token
			# params[:email]
			@user = User.find_by(email: params[:email])
			if not (@user and @user.activated? and BCrypt::Password.new(@user.reset_digest) == params[:id])
				redirect_to root_url, notice: "Failed to authorize the link...#{@user.reset_digest}" 
			elsif @user.reset_sent_at < 2.hours.ago
				redirect_to new_password_reset_url, notice: "Password reset auhorization link expired, try again..." 
			end
		end

		def bounce_logged_in_user
			redirect_to edit_user_path(current_user), notice: "You logged in already..." if logged_in?
		end

end
