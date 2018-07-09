# frozen_string_literal: true

class StaticPagesController < ApplicationController
  authorize_resource class: false

  def home
    @q = Product.ransack params[:q]
    @products = @q.result.stocking.by_active.newest.includes(:images)
                  .paginate page: params[:page], per_page: Settings.paginate.product.per_page
  end

  def help; end

  def about; end

  def contact; end
end
