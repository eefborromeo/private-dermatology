class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.references :user, foreign_key: true
      t.references :slot, foreign_key: true
      t.text :reason
      t.text :note
      t.integer :status
      t.boolean :interaction

      t.timestamps
    end
  end
end
