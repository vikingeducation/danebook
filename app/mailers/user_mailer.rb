class UserMailer < ApplicationMailer
  default :from => "no-reply@danebook.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Danebook!")
  end
end
