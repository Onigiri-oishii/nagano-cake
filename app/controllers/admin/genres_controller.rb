class Admin::GenresController < ApplicationController
  def index
  	@genre = Genre.new
  	@genres = Genre.all
  end

  def create
  	if Genre.create(params_genre)
  		redirect_to admin_genres_path
  	else
  		@genre = Genre.new
  		@genres = Genre.all
  		render "admin/genres/index"
  	end
  end

  def edit
  end

  def update
  end

  private
  def params_genre
  	params.require(:genre).permit(:name, :status)
  end

end
