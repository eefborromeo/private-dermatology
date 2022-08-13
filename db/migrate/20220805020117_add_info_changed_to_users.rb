class AddInfoChangedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :info_changed, :boolean, default: true
  end
end
