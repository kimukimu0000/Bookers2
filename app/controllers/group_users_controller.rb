class GroupUsersController < ApplicationController
  before_action :set_group
  before_action :ensure_not_owner

  def create
    Current.user.group_users.find_or_create_by!(group: @group)

    redirect_to group_path(@group), status: :see_other
  end

  def destroy
    membership = Current.user.group_users.find_by(group: @group)
    membership.destroy! if membership

    redirect_to group_path(@group), status: :see_other
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def ensure_not_owner
    if @group.owner_id == Current.user.id
      redirect_to group_path(@group),
                  alert: "オーナーは参加・退出の操作ができません。",
                  status: :see_other
    end
  end
end