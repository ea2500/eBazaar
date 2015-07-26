class AccountActivationsController < ApplicationController
	before_action :bounce_logged_in_user
	before_action :set_user, only: [:edit, :create]

	def new
	end

	def edit
	    if @user and BCrypt::Password.new(@user.activation_digest) == params[:id]
    	@user.update_attribute(:activated, true)
    	@user.update_attribute(:activated_at, Time.zone.now)
    	UserMailer.welcome(@user).deliver
    	redirect_to login_url, notice: "Congrats! your account is activated, now you can login..."
		end
	end

	def create
		if @user
			if @user.activated?
				redirect_to login_url, notice: "Your account is already active, please log in..."
			else
				@user.set_activation_digest
        UserMailer.account_activation(@user).deliver
        redirect_to root_url, notice: "Please check your email for your account activation..."
			end
		else
			flash.now[:failure] = "This email is not registered with us..."
			render :new
		end
	end

	private
		def set_user
			@user=User.find_by(email: params[:email].downcase)
		end

		def bounce_logged_in_user
			redirect_to root_url, notice: "You already logged in and active..." if logged_in?
		end
	
end
