class Admin::InventoryController < ApplicationController
    before_action :is_admin

    def index
        @products = Product.all
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)

        if @product.save
            redirect_to admin_inventory_index_path, notice: "Product added to inventory"
        else
            render :new
        end
    end

    private

    def is_admin
        redirect_to root_path unless current_user.admin?
    end

    def product_params
        params.require(:product).permit(:product_name, :product_desc, :price, :stock)
    end
end
