# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  include CartsHelper

  before_action :load_categories, :load_cart

  private

  def load_categories
    @categories = Category.all
  end

  def load_cart
    set_cart
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "users.new.please_log_in"
    redirect_to login_path
  end

  def load_products_in_cart
    @products_in_cart = Product.load_product_by_ids session[:cart].keys
  end

  def load_quantity_in_cart
    @products_in_cart.each do |product|
      product.quantity_in_cart = session[:cart][product.id.to_s]
    end
  end
end
