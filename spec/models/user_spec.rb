require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) { create(:user) }

  describe "after creation" do
    it "sends a confirmation email" do
      new_user = build(:user)
      expect { new_user.save }.to change(Devise.mailer.deliveries, :count).by(1)
    end
  end
end
