class ApplicationController < ActionController::Base
  def hello
    render html: 'Chaaaa'
  end

  helper_method :current_user, :logged_in?

  def current_user

    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
    # this is a memoization technique used to check for the logged in user if the user is already there it will simply return instance variable if not then it will find one and then return it.
  
  end

  def logged_in?

    !!current_user #!! is used to convert a value into boolean

  end

end
