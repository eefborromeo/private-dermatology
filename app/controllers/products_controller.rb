class ProductsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show]

    def index
        @products = Product.all
    end

    def show
        @product = Product.find(params[:id])
        if user_signed_in?
            @cart_item = current_user.cart_items.new
        end
    end
end
