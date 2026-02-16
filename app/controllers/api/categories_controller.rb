module Api
  class CategoriesController < Api::ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_category, only: [:update, :destroy, :show]

    def update
      if @category.update(category_params)
        render json: {category: @category.as_json,  
                      message: "Category updated successfully"},
                      status: :ok
      else
        render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      @category = Category.find(params[:id])
      render json: @category, status: :ok
    end

    def index

      limit = params[:limit].to_i
      limit = 3 if limit <= 0  
      offset = params[:offset].to_i
      offset = 0 if offset < 0  
      total_count = Category.all.count
      categories = Category.limit(limit).offset(offset)
      render json: {
        categories: categories.as_json(only: [:id, :name]),
        meta: {
          limit: limit,
          offset: offset,
          total_count: total_count
        }
      }, status: :ok
    end

    def create
      category = Category.new(category_params)

      if category.save
        render json: {category: category.as_json(only: [:id, :name]),
              message: "Category created successfully"}, status: :created
      else
        render json: { errors: category.errors.full_messages }, 
        status: :unprocessable_entity
      end
    end

    def destroy
      @category.destroy

      render json: { message: "Category deleted successfully" },
            status: :ok
    end

  private

    def set_category
      @category = Category.find(params[:id])
    end
    def category_params
      params.require(:category).permit(:name)
    end

    def require_admin 
      true
    end

  end
end