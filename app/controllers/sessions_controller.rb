class SessionsController < ApplicationController
  

  def new
    @user = User.new
  end
  
  def create
    email = params[:session][:email]
    username = params[:session][:username]
    password = params[:session][:password]
    # byebug
    check = password == ''
    if((username == '') and (email != ''))

      if (check)
        flash[:alert] = "Enter a password."
        redirect_to login_path
      else
        user = User.find_by(email: email)
        authenticate = (user && user.authenticate(password))

        if (authenticate)
          session[:user_id] = user.id
          # byebug
          flash[:notice] = "Log in successful."
          redirect_to user_path(user)
        else
          flash[:alert] = "credentials were not correct."
          redirect_to login_path
        end

      end

    elsif((email == '') and (username != ''))

      if (check)
        flash[:alert] = "Enter a password."
        redirect_to login_path
      else
        user = User.find_by(username: username)
        authenticate = (user && user.authenticate(password))
        session[:user_id] = user.id
        # byebug
        if (authenticate)
          flash[:notice] = "Log in successful."
          redirect_to user_path(user)
        else
          flash[:alert] = "Credentials were not correct."
          redirect_to login_path
        end

      end

    else 

      flash[:alert] = "Enter a username or email."
      redirect_to login_path

    end

  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end

end