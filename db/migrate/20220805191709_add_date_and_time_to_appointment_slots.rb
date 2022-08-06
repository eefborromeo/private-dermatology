class AddDateAndTimeToAppointmentSlots < ActiveRecord::Migration[6.1]
  def change
    add_column :slots, :date, :date
    add_column :slots, :time, :time
  end
end
