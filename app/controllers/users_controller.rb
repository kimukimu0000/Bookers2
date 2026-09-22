class UsersController < ApplicationController
  def index
    @users = User.all
    @user = Current.user
    @book = Book.new
  end

def show
  @user = User.find(params[:id])
  @books = @user.books
  @book = Book.new
end

def edit
  @user = User.find(params[:id])

  unless @user == Current.user
    redirect_to user_path(Current.user)
    return
  end
end
def update
  @user = User.find(params[:id])

  unless @user == Current.user
    redirect_to users_path
    return
  end

  if @user.update(user_params)
    redirect_to user_path(@user), notice: "User was successfully updated."
  else
    render :edit, status: :unprocessable_entity
  end
end

private

def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
end
end