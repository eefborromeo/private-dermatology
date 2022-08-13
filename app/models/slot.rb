class Slot < ApplicationRecord
  has_one :appointment

  validates :date, presence: true
  validates :time, presence: true
  validates :interaction, presence: true

  enum interaction: [:online, :face_to_face, :both]
  after_initialize :set_default_interaction, :if => :new_record?
  def set_default_interaction
    self.interaction ||= :both
  end
end
