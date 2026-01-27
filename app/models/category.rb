class Category < ApplicationRecord

  validates :name, presence: true, uniqueness: true, length: { maximum: 20, minimum: 3 }

end