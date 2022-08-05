class Product < ApplicationRecord
    has_many :cart_items
    has_many :users, through: :cart_items
    has_one_attached :product_image
end
