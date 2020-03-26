class CartProduct < ApplicationRecord
	belongs_to :user
	belongs_to :product

	validates :number, presence: true
end
