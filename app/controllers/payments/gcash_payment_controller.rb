class Payments::GcashPaymentController < ApplicationController
  include Payments::GcashPaymentHelper

  def create
    if params[:appointment_id]
      session[:transaction_data] = params[:appointment_id]

      if check_slot_availability_before_payment(params[:appointment_id])
        _process(cart_index_path)
      else
        redirect_to root_path, alert: "Something went wrong. Please try again"
      end
    else
      if check_product_stock_availability_before_payment(session[:transaction_data])
        _process(appointment_index_path)
      else
        redirect_to root_path, alert: "Something went wrong. Please try again"
      end
    end
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

  private

  def _process(path_fallback)
    if params[:amount].to_i < 100
      redirect_to path_fallback, alert: "GCash payments only allow transactions more than ₱100." 
      return
    end

    response = Payment::GcashPayment.initialize_source(params[:amount], params[:payment_category])
    session[:gcash_source_id] = response[:source_id]
    session[:payment_category] = response[:payment_category]
    session[:transaction_amount] = response[:amount]
    
    redirect_to response[:source_checkout_url]
  end
end