require 'rails_helper'

RSpec.describe "AppointmentTransactions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/appointment_transactions/index"
      expect(response).to have_http_status(:success)
    end
  end

end
