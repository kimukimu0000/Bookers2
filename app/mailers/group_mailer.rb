class GroupMailer < ApplicationMailer
  def event_notice
    @group = params[:group]
    @user = params[:user]
    @title = params[:title]
    @body = params[:body]

    mail(
      from: ENV.fetch("GMAIL_USERNAME"),
      to: @user.email_address,
      subject: @title
    )
  end
end