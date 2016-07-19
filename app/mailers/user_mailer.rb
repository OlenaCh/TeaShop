class UserMailer < ActionMailer::Base
  default from: "noreply@example.com" #add real mailer here

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registration Confirmation")
  end
end

