class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :cart_items
  has_many :products, through: :cart_item

  validates :full_name, presence: true
  validates :gender, presence: true
  validates :dob, presence: true
  validates :address, presence: true
  validates :contact_no, presence: true
end
