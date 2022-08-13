class Appointment < ApplicationRecord
  belongs_to :slot
  belongs_to :user

  validates :reason, presence: true, length: { minimum: 2 }

  before_create :set_interaction

  def set_interaction
    slot = Slot.find(self.slot_id)

    if slot.interaction == 1
      self.interaction = "Face to Face"
    else
      self.interaction = "Online"
    end
  end

  enum status: [:reserved, :confirmed, :cancelled, :completed]
  after_initialize :set_default_status, :if => :new_record?

  def set_default_status
    self.status ||= :reserved
  end
end
