class SessionsController < ApplicationController

  def new
    @us=User.all.order(:email)
    log_in_with_cookies
  end

  def create
    user=User.find_by(email: params[:email])
    # flash[:inform]="I am here in create"
    if user and user.authenticate(params[:password].downcase)
      log_in user, remember_me: params[:remember_me]
      delete_cookies_and_dummy unless params[:remember_me]
      redirect_to catalog_path
      flash[:notice]="Logged in..." 
    else
      redirect_to login_url
      flash[:failure]="invalid email/password..."
    end
  end

  def destroy
  	log_out_user 
  	redirect_to root_url
    flash[:notice]="Logged out..."
  end

end
