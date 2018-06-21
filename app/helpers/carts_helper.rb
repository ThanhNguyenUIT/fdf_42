# frozen_string_literal: true

module CartsHelper
  def set_cart
    @cart = session[:cart] ||= {}
  end

  def reset_cart
    session[:cart] = {}
  end

  def is_empty_cart?
    session[:cart].blank?
  end

  def sum_total_price
    @products_in_cart.collect{|product| product.quantity_in_cart * product.price}.sum
  end
end
