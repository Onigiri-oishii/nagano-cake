class Admin::GenresController < ApplicationController
  def index
  end

  def create
  end

  def edit
  end

  def update
  	　@genre = Genre.find(params[:id])
  end

  private
      def genre_params
    　params.require(:genre).permit(:ststus)
      end
end
