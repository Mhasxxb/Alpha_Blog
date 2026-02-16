class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories
  
  validates :name, presence: true, uniqueness: true, length: { maximum: 20, minimum: 3 }

end