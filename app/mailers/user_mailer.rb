class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("msg.acount_active")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: "Password reset"
  end
end
