# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart, :find_product, only: :add_cart

  def add_cart
    if session[:cart].key?(@product.id.to_s)
      session[:cart][@product.id.to_s] += Settings.quantity.one
    else
      session[:cart][@product.id.to_s] = Settings.quantity.one
    end

    respond_to do |format|
      format.html{render "static_pages/home"}
      format.json {}
      format.js
    end
  end

  private

  def find_product
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:danger] = t "carts.couldnt_found"
    redirect_to root_path
  end
end
