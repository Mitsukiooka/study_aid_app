class NotificationMailer < ApplicationMailer
  
  def notification_mail(plan, user)
    @plan = plan
    @user = user
    mail to: @user.email, from: "mooka0907@gmail.com", subject: "学習計画 #{@plan.title}が作成されました！"
  end
end
