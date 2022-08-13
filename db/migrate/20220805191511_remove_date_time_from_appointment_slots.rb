class RemoveDateTimeFromAppointmentSlots < ActiveRecord::Migration[6.1]
  def change
    remove_column :slots, :date, :datetime
  end
end
