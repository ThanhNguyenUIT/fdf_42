# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  include CartsHelper

  before_action :load_categories_header, :load_cart
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :account_update, keys: %i(name phone address city)
    devise_parameter_sanitizer.permit :sign_up, keys: %i(name phone address city)
  end

  private

  def load_categories_header
    @categories = Category.by_active
  end

  def load_cart
    set_cart
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
