# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @products = Product.stocking.by_active.newest
                       .paginate page: params[:page], per_page: Settings.paginate.product.per_page
  end

  def help; end

  def about; end

  def contact; end
end
