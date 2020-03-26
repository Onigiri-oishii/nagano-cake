class Admin::GenresController < ApplicationController
  def index
  	@genre = Genre.new
  	@genres = Genre.all
  end

  def create
  	if genre = Genre.create(params_genre)
  		redirect_to admin_genres_path
  	else
  		@genre = Genre.new
  		@genres = Genre.all
  		render "admin/genres/index"
  	end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(params_genre)
      #productのgenre_statusを更新
      pro = Product.all
      pro.each do |p|
        if p.genres_id == @genre.id
          p.update_columns(genre_status: @genre.status)
        end
      end
      redirect_to admin_genres_path
    else
      render "admin/genres/edit"
    end
  end

  private
  def params_genre
    params.require(:genre).permit(:name, :status)
  end

end
