class Paymongo::WebhookController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    render :json => {status: 'ok'}, status: :ok
    if params["data"]["attributes"]["type"] == "source.chargeable"
      redirect_to root_path, notice: "Finish this up developer"
    end
  end
end