module Api
  class UsersController < Api::ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :require_user, only: [:update]
    before_action :require_same_user, only: [:update, :destroy]

    # GET /api/users
    def index
      limit = params[:limit].to_i
      limit = 3 if limit <= 0

      offset = params[:offset].to_i
      offset = 0 if offset < 0

      users = User.limit(limit).offset(offset)
      total_count = User.count
      articles_count = User.articles.count
      render json: {
        users: users.as_json(),
        articles_count: articles_count,
        meta: {
          total_count: total_count,
          limit: limit,
          offset: offset
        }
      }, status: :ok
    end

    # GET /api/users/:id
    def show
      articles = @user.articles.limit(params[:limit].to_i || 3).offset(params[:offset].to_i || 0)
      total_articles = @user.articles.count

      render json: {
        user: @user.as_json(only: [:id, :username, :email]),
        articles: articles.as_json(only: [:id, :title, :description]),
        meta: {
          total_articles: total_articles,
          limit: params[:limit].to_i || 3,
          offset: params[:offset].to_i || 0
        }
      }, status: :ok
    end

    # POST /api/users
    def create
      user = User.new(user_params)

      if user.save
        render json: {
          user: user.as_json(only: [:id, :username, :email]),
          message: "User created successfully! Welcome, #{user.username}"
        }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/users/:id
    def update
      if @user.update(user_params)
        render json: {
          user: @user.as_json(only: [:id, :username, :email]),
          message: "#{@user.username} updated successfully"
        }, status: :ok
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/users/:id
    def destroy
      @user.destroy
      render json: { message: "User and contributions deleted successfully" }, status: :ok
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    # Temporary stub for testing; replace with actual authentication
    def require_user
      @current_user ||= User.first
    end

    def current_user
      @current_user
    end

    def require_same_user
      unless current_user == @user || current_user.admin?
        render json: { error: "You can only edit your own account" }, status: :forbidden
      end
    end
  end
end
















# module Api
#   class UsersController < Api::ApplicationController

# before_action :get_user, only: [:edit, :update, :show, :destroy ]
# before_action :require_user, only: [:edit, :update]
# before_action :require_same_user, only: [:edit, :update, :destroy]


# def new
#   @user = User.new
#   @text = "Sign up for MyBlog"
# end

# def create
#   @user = User.new(get_user_params)
#   if @user.save

#     flash[:notice] = "User created successfully! Welcome, #{@user.username}"

#     redirect_to login_path
#   else 
#     render :new
#   end
# end

# def edit 
#   @text = "Update your info"
# end

# def update
#   # byebug

#   check = ((@user.username == params[:user][:username]) and (@user.email == params[:user][:email]))
#   if(check)
#     flash[:notice] = "No changes were made."
#     redirect_to user_path
#   else
#     if @user.update(get_user_params)
#       flash[:notice] = "#{@user.username.capitalize} updated successfully"
#       redirect_to user_path
#     else
#       render :edit
#     end
#   end
# end

# def show
#   @articles = @user.articles.paginate(page: params[:page], per_page: 3)
# end

# def index
#   @users = User.paginate(page: params[:page], per_page: 3)
# end

# def destroy

#   @user.destroy
#   session[:user_id] = nil if @user == current_user
#   flash[:notice] = "User and contributions were deleted successfully."
#   redirect_to root_path

# end

# private

# def get_user_params
#   params.require(:user).permit(:username, :email, :password)
# end

# def get_user
#   # byebug
#   @user = User.find(params[:id])
# end

# def require_same_user
#   if current_user != @user && !current_user.admin
#     flash[:alert] = "You can only edit your own account"
#     redirect_to @user
#   end
# end


# end
# end