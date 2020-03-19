class Admin::ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
    @genres = Genre.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product.id)
    else
      render "admin/products/new"
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private
  def product_params
    params.require(:product).permit(:name, :introduction, :genres_id, :no_tax, :sale_status)
  end


end
