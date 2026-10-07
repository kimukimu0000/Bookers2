class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update]
  before_action :ensure_owner, only: [:edit, :update]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Current.user.owned_groups.build(group_params)

    if @group.save
      redirect_to group_path(@group), notice: "グループを作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "グループを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def ensure_owner
    unless @group.owner_id == Current.user.id
      redirect_to group_path(@group), alert: "オーナーのみ編集できます。"
    end
  end

  def group_params
    params.require(:group).permit(:name, :introduction)
  end
end