class TransactionController < ApplicationController
  include TransactionHelper
  before_action :check_user_info, if: :user_signed_in?

  def index
    @transactions = current_user.transactions
  end

  def show
  end

  def new
    if params[:i].nil? || params[:i].length == 0
      redirect_to cart_index_path, alert: "Please select items"
    else
      @data = display_cart_items_to_checkout(params[:i])
    end
  end

  def create
    if params[:data].nil? || params[:data].length == 0
      redirect_to root_path, alert: "Something went wrong, please try again."
    else
      process = process_transaction(params[:data])
    end
    
    if process == true
      redirect_to products_path, notice: "Succ"
    else
      redirect_to cart_index_path, alert: "Failure"
    end
  end

  def destroy
  end
end