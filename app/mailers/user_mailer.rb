class UserMailer < ApplicationMailer	
  def order_creation email
    mail to: email, subject: "Order creation"
  end
end
