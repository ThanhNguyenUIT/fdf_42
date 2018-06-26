# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @products = Product.stocking.by_active.order_by_desc
  end

  def help; end

  def about; end

  def contact; end
end
