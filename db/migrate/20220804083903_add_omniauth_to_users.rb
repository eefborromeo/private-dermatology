class AddOmniauthToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :image, :string, default: "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png"
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :access_token, :string
    add_column :users, :refresh_token, :string
    add_column :users, :expires_at, :integer
  end
end
