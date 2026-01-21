class UsersController < ApplicationController
before_action :get_user, only: [:edit, :update, :show ]
def new
  @user = User.new
end

def create
  @user = User.new(get_user_params)
  if @user.save

    flash[:notice] = "User created successfully"

    redirect_to root_path
  else 
    render :new
  end
end

def edit 
end

def update
end

def show
end

def index
  @users = User.all
end
private

def get_user_params
  params.require(:user).permit(:username, :email, :password)
end

def get_user
  @user = User.find(params[:id])
end

end