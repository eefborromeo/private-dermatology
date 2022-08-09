class Payments::GcashPaymentController < ApplicationController
  def create
    if params[:appointment_id]
      session[:transaction_data] = params[:appointment_id]
    end

    response = Payment::GcashPayment.initialize_source(params[:amount], params[:payment_category])
    session[:gcash_source_id] = response[:source_id]
    session[:payment_category] = response[:payment_category]
    session[:transaction_amount] = response[:amount]
    
    redirect_to response[:source_checkout_url]
  end

  def success    
    redirect_to complete_transaction_path
  end

  def failed
    session.delete(:gcash_source_id)
    session.delete(:payment_category)
    session.delete(:transaction_amount)
    session.delete(:transaction_data)
    redirect_to root_path, alert: "Your transaction failed, please try again."
  end
end