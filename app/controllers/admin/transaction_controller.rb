class Admin::TransactionController < ApplicationController
  before_action :check_user_info, if: :user_signed_in?
  include Admin::TransactionHelper

  def index
    @product_transactions = display_product_transactions
    @appointment_transactions = display_appointment_transactions
  end

  def show
  end

  def destroy
  end
end