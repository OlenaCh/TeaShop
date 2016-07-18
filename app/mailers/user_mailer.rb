class UserMailer < ActionMailer::Base
  #add real mailer here
  default :from => "me@mydomain.com"

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registration Confirmation")
  end
end

