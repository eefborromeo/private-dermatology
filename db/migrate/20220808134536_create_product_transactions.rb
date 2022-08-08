class CreateProductTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :product_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint :transaction_id
      t.string :prod_name
      t.text :prod_desc
      t.integer :prod_price
      t.integer :prod_quantity
      t.integer :prod_total

      t.timestamps
    end
  end
end
