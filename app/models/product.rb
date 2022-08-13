class Product < ApplicationRecord
    has_many :cart_items
    has_many :users, through: :cart_items
    has_one_attached :product_image

    validates :product_name, presence: true, length: {minimum: 2}
    validates :product_desc, presence: true, length: {minimum: 2}
    validates :price, presence: true, format: { with: /\A\d+(?:\.\d{2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
    validates :stocks, presence: true, numericality: { greater_than: 0 }
    validate :acceptable_image

    def acceptable_image
        if product_image.attached? 
            unless product_image.byte_size <= 2.megabyte
                errors.add(:product_image, "is too big")
            end

            acceptable_types = ["image/jpeg", "image/png"]
            unless acceptable_types.include?(product_image.content_type)
                errors.add(:product_image, "must be a JPEG or PNG")
            end
        else
            errors.add(:product_image, 'is required')
        end
    end

    
end
