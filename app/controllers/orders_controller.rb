# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :logged_in_user, :load_products_in_cart, :load_quantity_in_cart, only: %i(new create)
  before_action :check_cart, only: :create

  def new
    @order = Order.new
  end

  def create
    ActiveRecord::Base.transaction do
      @order = Order.new order_params
      if @order.save!
        @products_in_cart.each do |product|
          unit_price = product.price
          total_price = product.quantity_in_cart * unit_price
          order_detail = @order.order_details.new(order_id: @order.id, product_id: product.id,
            quantity: product.quantity_in_cart, unit_price: unit_price, total_price: total_price)
          order_detail.save!
        end
        OrderMailer.order_successful(current_user, @order).deliver_now
        after_order_successful
      end
    end
  rescue StandardError
    flash.now[:danger] = t ".order_failed"
    render :new
  end

  private

  def order_params
    params.require(:order).permit :user_id, :price, :receiver, :phone, :address
  end

  def after_order_successful
    flash[:success] = t ".order_successful"
    reset_cart
    redirect_to root_path
  end

  def check_cart
    return unless is_empty_cart?
    flash[:danger] = t ".empty_cart"
    redirect_to carts_path
  end
end
