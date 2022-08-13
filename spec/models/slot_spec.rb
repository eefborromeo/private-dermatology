require 'rails_helper'

RSpec.describe Slot, type: :model do
  let(:slot) { create(:slot) }

  it "has a date" do
    slot.date = ""
    expect(slot).to_not be_valid
  end

  it "has time" do
    slot.time = ""
    expect(slot).to_not be_valid
  end

  it "has an interaction" do
    slot.interaction = ""
    expect(slot).to_not be_valid
  end
end
