class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    Current.user.follow(@user)
    redirect_back fallback_location: user_path(@user)
  end

  def destroy
    Current.user.unfollow(@user)
    redirect_back fallback_location: user_path(@user)
  end

  def followings
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end