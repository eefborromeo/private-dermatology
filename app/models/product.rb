class Product < ApplicationRecord
    has_many :cart_items
    has_many :users, through: :cart_items
    has_one_attached :product_image

    validate :acceptable_image

    def acceptable_image
        return unless product_image.attached?

        unless product_image.byte_size <= 2.megabyte
            errors.add(:product_image, "is too big")
        end

        acceptable_types = ["image/jpeg", "image/png"]
        unless acceptable_types.include?(product_image.content_type)
            errors.add(:product_image, "must be a JPEG or PNG")
        end
    end

    
end
