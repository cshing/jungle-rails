class OrderMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'
 
  def order_receipt_email(params)
    @order = params[:order]
    mail(to: @order.email, subject: "Order No.#{@order.id} - Thank you for your order! ") do |format|
      format.html { render 'order_receipt_email' }
    end
  end
end
