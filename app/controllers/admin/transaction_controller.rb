class Admin::TransactionController < ApplicationController
  before_action :check_user_info, if: :user_signed_in?
  
  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def destroy
    transaction = Transaction.find(params[:id])
    transaction.destroy!
    redirect_to admin_transaction_index_path, notice: "Successfully deleted transaction"
  end
end