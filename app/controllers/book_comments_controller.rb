class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = Current.user.book_comments.new(book_comment_params)
    @book_comment.book = @book
    @book_comment.save

    @book_comment = BookComment.new
  end

  def destroy
    @book = Book.find(params[:book_id])
    book_comment = @book.book_comments.find_by!(
      id: params[:id],
      user_id: Current.user.id
    )
    book_comment.destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end