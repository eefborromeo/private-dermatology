class AppointmentTransactionsController < ApplicationController
  before_action :check_user_info, if: :user_signed_in?
  before_action :is_admin
  before_action :set_appt, only: [:edit, :update]

  def index
    @appt = AppointmentTransaction.all
  end

  def edit
  end

  def update

    @appt = AppointmentTransaction.find(params[:id])
    @appt.appt_status = "completed"
    if @appt.save
      redirect_to appointment_transactions_path, notice: 'The status has been updated.'
    end
  end

  private
  def set_appt
    @appt = AppointmentTransaction.find(params[:id])
  end

  def appt_params
    params.permit(:id, :user_id, :transaction_id, :transaction_amount, :appt_status, :appt_note, :appt_reason)
  end
end
