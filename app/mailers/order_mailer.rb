# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def order_successful current_user, order
    @user = current_user
    @order = order
    mail to: @user.email, subject: t(".subject")
  end

  def cancel_order current_user, order
    @user = current_user
    @order = order
    mail to: @user.email, subject: t(".subject")
  end
end
