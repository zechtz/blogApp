module SessionHelper

  # redirect visitor to the page he / she was trying to access before login in or just 
  # use the default redirect set in the controller action 
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  # store the location's url the user was trying to access so that when they are logged in 
  # we redirect them to that stored location 
  def store_location
    session[:return_to] = request.url if request.get?
  end

end
