class Paymongo::WebhookController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  # Developer think of how to delete the created transaction history if the source status becomes cancelled
  def create
    render :json => {status: 'ok'}, status: :ok
    if params["data"]["attributes"]["type"] == "source.chargeable"
      # process_webhook_event
      # enable the method above once the website will be live and will start accepting real money
    else
      return
    end
  end

  private

  def process_webhook_event
    # this method will only be triggered by an ansync event from paymongo
    transaction = ""
    appt = AppointmentTransaction.where(transaction_id: params['data']['attributes']['data']['id'])
    prod = ProductTransaction.where(transaction_id: params['data']['attributes']['data']['id'])

    if appt.length != 0
      transaction = appt[0]
    elsif prod.length != 0
      transaction = prod[0]
    else
      return
    end

    response = Payment::GcashPayment.process_payment(transaction.transaction_amount, transaction.transaction_id)
    transaction.transaction_id = response
    transaction.save
  end
end