require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:current_user) { create(:confirmed_user) }
  let(:slot) { create(:slot) }
  let(:appointment) { create(:appointment, user: current_user, slot: slot) }
  

  it "have user id" do
    expect{create(:appointment, slot: slot)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "have slot id" do
    expect{create(:appointment, user: current_user)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "have appointment reason" do
    appointment.reason = ""
    expect(appointment).to_not be_valid
  end
end
