class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def show
    
  end

  def index
    
  end

  def create
    @category = Category.create(category_params)
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
end