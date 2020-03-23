class OrderProduct < ApplicationRecord
	enum production_status: {着手不可: 0, 製作待ち: 1, 製作中: 2, 製作完了: 3}

	belongs_to :order, optional: true
	belongs_to :product

	validates :number, presence: true, length:{minimum: 1}
end
