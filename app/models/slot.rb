class Slot < ApplicationRecord
  has_one :appointment

  enum interaction: [:online, :face_to_face, :both]
  after_initialize :set_default_interaction, :if => :new_record?
  def set_default_interaction
    self.interaction ||= :both
  end
end
