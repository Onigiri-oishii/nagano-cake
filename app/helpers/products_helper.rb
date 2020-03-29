module ProductsHelper
  def include_tax(no_tax)
    price = (no_tax * 1.1).round
    price.to_s(:delimited, delimiter: ',')
  end

  def get_subtotal(no_tax, number)
		price = (no_tax * 1.1).round
		subtotal = price * number
		subtotal.to_s(:delimited, delimiter: ',')
	end

	def total_price(no_tax, number)
		price = (no_tax * 1.1).round
		subtotal = price * number
	end
end
