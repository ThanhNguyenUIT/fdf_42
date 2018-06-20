# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart, :find_product, only: %i(add_cart remove_cart update_subtotal)
  before_action :load_products_in_cart, :load_quantity_in_cart, only: %i(index update_subtotal)

  def index; end

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

  def remove_cart
    session[:cart].delete(@product.id.to_s) if session[:cart].key? @product.id.to_s
    redirect_to carts_path
  end

  def update_subtotal
    session[:cart][params[:product_id].to_s] = params[:quantity].to_i
    @product.quantity_in_cart = params[:quantity].to_i

    respond_to do |format|
      format.html{render "carts/index"}
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
