class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :receivers, dependent: :destroy
  has_many :cart_products, dependent: :destroy

  validates :firstname, presence: true, length: {in:1..50}
  validates :lastname, presence: true, length: {in:1..50}
  validates :firstname_kana, presence: true, length: {in:1..20}
  validates :lastname_kana, presence: true, length: {in:1..20}
  validates :email, presence: true
  validates :encrypted_password, presence: true, length: {in:6..20}
  validates :postal, presence: true
  validates :address, presence: true
  validates :telephone, presence: true

end
