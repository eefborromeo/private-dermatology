class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.text :product_desc
      t.integer :price
      t.integer :stocks

      t.timestamps
    end
  end
end
