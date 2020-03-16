class Product < ApplicationRecord
	has_many :order_products
	has_many :cart_products, dependent: :destroy
	belongs_to :genre


	validates :genres_id, presence: true
	validates :name, presence: true
	validates :introduction, presence: true
	validates :no_tax, presence: true
	validates :sale_status, presence: true
	#defaultでtrueが入っている
	#商品新規登録画面では「販売」「売切」の２択で表示する「選択してください」は含めない



	attachment :image #refile で使用 id含めません
end
