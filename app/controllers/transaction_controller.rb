class TransactionController < ApplicationController
  before_action :check_user_info, if: :user_signed_in?
  include TransactionHelper

  def index
    @product_transactions = current_user.product_transactions
    @appointment_transactions = current_user.appointment_transactions
  end

  def show
  end

  def new
    if params[:i].nil? || params[:i].length == 0
      redirect_to cart_index_path, alert: "Please select items"
    else
      checkout = display_cart_items_to_checkout(params[:i])
      @data = checkout[0]
      session[:transaction_data] = checkout[0]
      @checkout_total = checkout[1]
    end
  end

  def complete
    if session[:payment_category] == "Dermatology Product Payment"
      process_product_transaction(session[:transaction_data], session[:gcash_transaction_id])
      redirect_to root_path, notice: "Your Product payment was successful!"
    else
      process_appointment_transaction(session[:transaction_data], session[:gcash_transaction_id])
      redirect_to root_path, notice: "Your Appointment payment was successful!"
    end
  end

  def destroy
  end
end