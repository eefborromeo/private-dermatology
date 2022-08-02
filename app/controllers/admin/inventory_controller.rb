class Admin::InventoryController < ApplicationController
    before_action :is_admin
    before_action :set_product, only: [:edit, :update, :destroy]

    def index
        @products = Product.all.order(:product_name)
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

    def edit
       
    end

    def update
        if @product.update(product_params)
            redirect_to admin_inventory_index_path, notice: "Product successfully edited"
        else 
            render :edit
        end
    end

    def destroy
        @product.destroy
        redirect_to admin_inventory_index_path, notice: "Product deleted"
    end

    private

    def is_admin
        redirect_to root_path unless current_user.admin?
    end

    def product_params
        params.require(:product).permit(:product_name, :product_desc, :price, :stocks)
    end

    def set_product
        @product = Product.find(params[:id])
    end
end
