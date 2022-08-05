class Appointment < ApplicationRecord
  belongs_to :slot
  belongs_to :user

  enum interaction: [:online, :face_to_face]
  after_initialize :set_default_interaction, :if => :new_record?
  def set_default_interaction
    self.interaction ||= :online
end
