class CartController < ApplicationController
    before_action :check_user_info, if: :user_signed_in?
    
    def index
        @cart_items = current_user.cart_items
    end

    def create
        @cart_item = current_user.cart_items.find_or_initialize_by(product_id: items_params[:product_id])
        @cart_item.quantity += items_params[:quantity].to_i

        if @cart_item.save
            redirect_to products_path, notice: "Item added to your cart."
        else
            redirect_to product_path(params[:product_id]), alert: "#{@cart_item.errors.first.message}"
        end
    end

    def destroy
        @cart_item = current_user.cart_items.find(params[:id])
        @cart_item.destroy
        redirect_to cart_index_path, notice: "Item removed from cart."
    end

    private

    def items_params
        params.require(:cart_item).permit(:product_id, :quantity)
    end
end
