class OrderMailer < ApplicationMailer 
  def create_order(id, email)
    @order = Order.find(id)
    mail(to: email, subject: 'Order Created!')
  end
end
