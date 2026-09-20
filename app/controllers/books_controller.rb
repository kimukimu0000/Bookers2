class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
    @user = Current.user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = Current.user.id

    if @book.save
      redirect_to book_path(@book),
                  notice: "Book was successfully created."
    else
      @books = Book.all
      @user = Current.user
      flash.now[:alert] = "#{@book.errors.count} errors prohibited this book from being saved."
      render :index, status: :unprocessable_entity
    end
  end

    def edit
  @book = Book.find(params[:id])

  unless @book.user == Current.user
    redirect_to books_path
end
end

def update
  @book = Book.find(params[:id])

  if @book.update(book_params)
    redirect_to book_path(@book),
                notice: "Book was successfully updated."
  else
    render :edit, status: :unprocessable_entity
  end
end

def destroy
  @book = Book.find(params[:id])
  @book.destroy

  redirect_to books_path,
              notice: "Book was successfully destroyed."
end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end