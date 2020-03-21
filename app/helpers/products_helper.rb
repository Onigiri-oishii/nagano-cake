module ProductsHelper
  def include_tax(no_tax)
    price = no_tax * 1.1
    price.floor.to_s(:delimited, delimiter: ',')
  end
end
