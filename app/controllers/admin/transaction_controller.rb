class Admin::TransactionController < ApplicationController
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