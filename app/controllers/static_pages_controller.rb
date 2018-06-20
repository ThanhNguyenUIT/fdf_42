# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @products = Product.load_product
  end

  def help; end

  def about; end

  def contact; end
end
