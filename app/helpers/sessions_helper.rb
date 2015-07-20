module SessionsHelper

	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end
	def logged_in?
		!current_user.nil?
	end
	
	def log_user_in(user, remember_me: false)
		session[:user_id]=user.id
		if remember_me
			cookies.permanent.signed[:user_id]=user.id
			cookies.permanent[:dummy]=user.reset_dummy_token
		end
		return current_user
	end

	def log_user_out
		cookies[:user_id]=nil
		cookies[:dummy]=nil
		current_user.update_attribute(:dummy, nil)
		session[:user_id]=nil
		return current_user
	end

	def bounce_not_logged_in_user
    unless logged_in?
      flash[:notice] = "Please log in."
      redirect_to login_url
    end
  end

  def bounce_non_admin_user
    unless logged_in? and current_user.admin?
      flash[:failure]="only admin can do that"
      redirect_to(root_url) 
    end
  end

	def valid_cookie_user
		cookie_user=User.find_by(id: cookies.signed[:user_id]) if cookies[:user_id] and cookies[:dummy]
		begin
	    	if cookie_user and BCrypt::Password.new(cookie_user.dummy) == cookies[:dummy]
	    		return cookie_user
	    	end
	    	rescue 
	    		return nil
	    end
	end
	def log_user_in_with_cookies
    log_user_in valid_cookie_user, remember_me: true
    redirect_to catalog_path
    flash[:success]="Remembered and logged in..."
	end

	

end
