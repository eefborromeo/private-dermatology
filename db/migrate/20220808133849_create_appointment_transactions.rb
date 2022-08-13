class CreateAppointmentTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :appointment_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :transaction_id
      t.string :transaction_amount
      t.date :appt_date
      t.time :appt_time
      t.string :appt_reason
      t.text :appt_note
      t.string :appt_interaction
      t.string :appt_status

      t.timestamps
    end
  end
end
