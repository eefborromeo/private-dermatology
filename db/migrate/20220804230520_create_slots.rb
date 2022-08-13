class CreateSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :slots do |t|
      t.datetime :date
      t.boolean :availability
      t.integer :interaction

      t.timestamps
    end
  end
end
