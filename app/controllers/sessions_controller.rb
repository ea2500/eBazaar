class SessionsController < ApplicationController

  def new
    @us=User.all.order(:admin).order(:id).order(:email)
    log_user_in_with_cookies if valid_cookie_user and not logged_in?
  end

  def create
    user=User.find_by(email: params[:email].downcase)
    if user.activated?
      if user and user.authenticate(params[:password])
        log_user_in user, remember_me: params[:remember_me]
        redirect_to catalog_path
        flash[:notice]="Logged in..." 
      else
        redirect_to login_url
        flash[:failure]="invalid email/password..."
      end
    else
      redirect_to root_url, notice: "your account is NOT active yet... check your email for activation link" 
    end
  end

  def destroy
  	log_user_out 
  	redirect_to root_url
    flash[:notice]="Logged out..."
  end

end
