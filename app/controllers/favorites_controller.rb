class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = Current.user.favorites.new(book: @book)
    favorite.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = Current.user.favorites.find_by(book: @book)
    favorite.destroy
  end
end