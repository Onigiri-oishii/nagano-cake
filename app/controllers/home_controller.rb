class HomeController < ApplicationController
  def top
  	#----------「無効なユーザー」がログインしたときに強制ログアウト----------
  	if user_signed_in?
  		if User.find(current_user.id).status == false
  			sign_out_and_redirect(current_user)
  		end
  	end

  	@genres = Genre.all
  	@products = Product.all
  	#5件表示
    @random = Product.order("RANDOM()").limit(4)
    #ランキング
    @rank = Product.find(OrderProduct.limit(4).order('sum_number desc').group(:product_id).sum(:number).keys)
  end

  def about
  end
end
