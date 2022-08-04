class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :cart_items
  has_many :products, through: :cart_item
         
  validates :full_name, presence: true
  validates :gender, presence: true
  validates :dob, presence: true
  validates :address, presence: true
  validates :contact_no, presence: true
  validates :email, uniqueness: true

  private

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    unless user
      user = User.create(
          email: auth.info.email,
          password: Devise.friendly_token[0,20],
          full_name: 'Please Update',
          gender: 'Select',
          dob: '2000-01-01 00:00:00',
          address: 'Please Update',
          contact_no: 'Please Update'
      )
    end
    user.image = auth.info.image
    user.uid = auth.uid
    user.provider = auth.provider
    user.access_token = auth.credentials.token
    user.expires_at = auth.credentials.expires_at
    user.refresh_token = auth.credentials.refresh_token
    user.save
    
    user
  end
end