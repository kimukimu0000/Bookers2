class GroupEventsController < ApplicationController
  before_action :set_group
  before_action :ensure_owner

  def new
  end

  def create
    @title = event_params[:title]
    @body = event_params[:body]

    if @title.blank? || @body.blank?
      flash.now[:alert] = "タイトルと本文を入力してください。"
      render :new, status: :unprocessable_entity
      return
    end

    unless @group.users.exists?
      flash.now[:alert] = "送信先のメンバーがいません。"
      render :new, status: :unprocessable_entity
      return
    end

    @group.users.each do |user|
      GroupMailer.with(
        group: @group,
        user: user,
        title: @title,
        body: @body
      ).event_notice.deliver_now
    end

    render :sent
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def ensure_owner
    unless @group.owner_id == Current.user.id
      redirect_to group_path(@group),
                  alert: "オーナーのみイベント通知を送れます。"
    end
  end

  def event_params
    params.require(:event).permit(:title, :body)
  end
end