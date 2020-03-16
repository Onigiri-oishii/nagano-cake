class Receiver < ApplicationRecord
	belongs_to :user

	validates :name, presence: true
	validates :address, presence: true
	validates :postal, presence: true
end
