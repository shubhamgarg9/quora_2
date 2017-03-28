class UserMailer < ApplicationMailer
  default from: 'shubhamrada@gmail.com'

  def welcome_email(user)
    @user = user
    @url  = 'nahi kia abhi'
    mail(to: @user.email, subject: 'Welcome to quora')
  end
end
