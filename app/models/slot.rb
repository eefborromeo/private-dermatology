class Slot < ApplicationRecord
  enum interaction: [:online, :face_to_face]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :online
  end
end
