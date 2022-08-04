require 'rails_helper'

RSpec.describe "Slots", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/slot/index"
      expect(response).to have_http_status(:success)
    end
  end

end
