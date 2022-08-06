class Appointment < ApplicationRecord
  belongs_to :slot
  belongs_to :user

  enum interaction: [:online, :face_to_face]
  after_initialize :set_default_interaction, :if => :new_record?
  def set_default_interaction
    self.interaction ||= :online
  end

  enum status: [:reserved, :confirmed, :cancelled, :completed]
  after_initialize :set_default_status, :if => :new_record?
  def set_default_status
    self.status ||= :reserved
  end
end
