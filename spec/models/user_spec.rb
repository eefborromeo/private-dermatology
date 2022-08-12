require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) { create(:user) }

  describe "upon creation" do
    before do
      expect(user).to be_valid
    end
    
    it "specifies full name with a minimum of 2 characters" do
      user.full_name = ""
      expect(user).to_not be_valid
    end

    it "specifies gender" do
      user.gender = ""
      expect(user).to_not be_valid
    end

    it "specifies date of birth" do
      user.dob = ""
      expect(user).to_not be_valid
    end

    it "specifies address" do
      user.address = ""
      expect(user).to_not be_valid
    end

    it "specifies contact number" do
      user.contact_no = ""
      expect(user).to_not be_valid
    end

    it "sepcifies email address" do
      user.email = ""
      expect(user).to_not be_valid
    end
  end

  describe "after creation" do
    it "sends a confirmation email" do
      new_user = build(:user)
      expect { new_user.save }.to change(Devise.mailer.deliveries, :count).by(1)
    end
  end
end
