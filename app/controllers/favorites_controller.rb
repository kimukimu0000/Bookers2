class FavoritesController < ApplicationController

    def create
    book = Book.find(params[:book_id])
    favorite = Current.user.favorites.new(book: book)
    favorite.save

    redirect_back fallback_location: book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = Current.user.favorites.find_by(book: book)
    favorite&.destroy

    redirect_back fallback_location: book_path(book)
  end

end
