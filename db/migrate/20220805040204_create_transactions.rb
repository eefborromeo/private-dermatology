class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :prod_name
      t.text :prod_desc
      t.integer :prod_price
      t.integer :prod_quantity
      t.integer :prod_total
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
