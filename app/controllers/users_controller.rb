class UsersController < ApplicationController
before_action :get_user, only: [:edit, :update, :show ]
def new
  @user = User.new
  @text = "Sign up for MyBlog"

end

def create
  @user = User.new(get_user_params)
  if @user.save

    flash[:notice] = "User created successfully! Welcome, #{@user.username}"

    redirect_to root_path
  else 
    render :new
  end
end

def edit 
  @text = "Update your info"
end

def update
  # byebug

  check = ((@user.username == params[:user][:username]) and (@user.email == params[:user][:email]))
  if(check)
    flash[:notice] = "No changes were made."
    redirect_to user_path
  else
    if @user.update(get_user_params)
      flash[:notice] = "#{@user.username.capitalize} updated successfully"
      redirect_to user_path
    else
      render :edit
    end
  end
end

def show
  @articles = @user.articles.paginate(page: params[:page], per_page: 3)
end

def index
  @users = User.paginate(page: params[:page], per_page: 3)
end
private

def get_user_params
  params.require(:user).permit(:username, :email, :password)
end

def get_user
  # byebug
  @user = User.find(params[:id])
end

end