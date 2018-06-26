# frozen_string_literal: true

class Admin::OrdersController < ApplicationController
  before_action :load_order, only: %i(show approve reject)
  before_action :load_orders, only: %i(index approve reject)

  def index; end

  def show; end

  def approve
    ActiveRecord::Base.transaction do
      if @order.ordered!
        @order.order_details.each do |order_detail|
          raise t(".not_enough") if order_detail.product.quantity < order_detail.quantity
          decrement_product_quantity order_detail.product, order_detail.quantity
        end
        OrderMailer.approve_order(@order).deliver_now
        respond_to do |format|
          format.html{render "orders/index"}
          format.json {}
          format.js
        end
      end
    end
  rescue StandardError => e
    flash[:danger] = t ".cant_approve_now"
    flash[:danger] = t ".not_enough_quantity" if e.message == t(".not_enough")
    redirect_to admin_orders_path
  end

  def reject
    ActiveRecord::Base.transaction do
      if @order.rejected!
        OrderMailer.reject_order(@order).deliver_now
        respond_to do |format|
          format.html{render "orders/index"}
          format.json {}
          format.js
        end
      end
    end
  rescue StandardError
    flash[:danger] = t ".cant_reject_now"
    redirect_to admin_orders_path
  end

  private

  def load_orders
    @orders = Order.newest
                   .paginate page: params[:page], per_page: Settings.paginate.order.per_page
  end

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:danger] = t ".couldnt_found"
    redirect_to admin_orders_path
  end

  def decrement_product_quantity product, quantity
    product.update quantity: product.quantity - quantity
  end
end
