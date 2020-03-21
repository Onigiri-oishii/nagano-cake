class Order < ApplicationRecord
	enum order_status: {入金待ち: 0,入金確認: 1,製作中: 2,発送準備中: 3,発送済み: 4}
	enum way: {クレジットカード: 0,銀行振込: 1}

	has_many :order_products, dependent: :destroy
	belongs_to :user

	validates :address, presence: true
	validates :postal, presence: true
end
