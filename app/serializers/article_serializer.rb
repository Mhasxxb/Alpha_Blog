module Api
  class ArticleSerializer < ActiveModel::Serializer
    include ActionView::Helpers::DateHelper

    attributes :id, :title, :description, :created_at, :user_name, :categories

    def created_at
      time_ago_in_words(object.created_at)
    end

    def updated_at
      time_ago_in_words(object.updated_at)
    end
    
    # Custom method to show user name
    def user_name
      object.user&.username
    end

    # Custom method to show categories
    def categories
      return [] unless object.categories.present?

      object.categories.map do |category|
        {
          id: category.id,
          name: category.name
        }
      end
    end
  end
end



