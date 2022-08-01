class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :gender, :string
    add_column :users, :dob, :datetime
    add_column :users, :contact_no, :string
    add_column :users, :address, :text
  end
end
