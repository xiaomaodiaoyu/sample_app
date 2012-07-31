module SessionsHelper
	def sign_in(user)
		# cookies[:remember_token] = { value:   user.remember_token,
        #                              expires: 20.years.from_now.utc }
    	cookies.permanent[:remember_token] = user.remember_token
    	self.current_user = user
 	end

 	# set
 	def current_user=(user)
 		@current_user = user
 	end

 	# get
 	def current_user
   	@current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
  	!current_user.nil?
  end

  def sign_out
    # Setting the current user to nil isn’t currently necessary
    # because of the immediate redirect in the destroy action, 
    # but it’s a good idea in case we ever want to use sign_out
    # without a redirect.
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end
end
