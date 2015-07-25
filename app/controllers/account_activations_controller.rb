class AccountActivationsController < ApplicationController

	def edit
		user=User.find_by(email: params[:email])
	    if user and BCrypt::Password.new(user.activation_digest) == params[:id]
    	user.update_attribute(:activated, true)
    	user.update_attribute(:activated_at, Time.zone.now)
    	UserMailer.welcome(user).deliver
    	redirect_to login_url, notice: "Congrats! your account is activated, now you can login..."
		end
	end

end
