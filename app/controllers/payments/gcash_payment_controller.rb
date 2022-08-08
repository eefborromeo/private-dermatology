class Payments::GcashPaymentController < ApplicationController
  def create
    if params[:appointment_id]
      session[:transaction_data] = params[:appointment_id]
    end

    response = Payment::GcashPayment.initialize_source(params[:amount], params[:payment_category])
    session[:gcash_transaction_id] = response[:transaction_id]
    session[:payment_category] = response[:payment_category]
    redirect_to response[:source_checkout_url]
  end

  def success    
    redirect_to complete_transaction_path
  end

  def failed
    redirect_to cart_index_path, alert: "Your transaction failed, please try again."
  end
end