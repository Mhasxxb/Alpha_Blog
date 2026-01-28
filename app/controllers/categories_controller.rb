class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    check = @category.name == params[:category][:name]
    if check
      flash[:notice] = "No changes were made."
      redirect_to category_path(@category.id)
      return
    end

    if @category.update(category_params)
      flash[:notice] = "Category was updated successfuly."
      redirect_to category_path(@category.id)
    else
      flash[:alert] = "Something went wrong."
    end
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page: params[:page], per_page: 3)
  end

  def index

    @categories = Category.paginate(page: params[:page], per_page: 3)
    
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was created successfully."
      redirect_to @category
    else
      render 'new'
    end
  end

private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin 
  
    if  !(logged_in? && current_user.admin?)
      flash[:alert] = "only admins can perform that action"
      redirect_to categories_path
    end
  end

end