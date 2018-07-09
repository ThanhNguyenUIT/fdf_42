# frozen_string_literal: true

class ProductsController < ApplicationController
  load_and_authorize_resource
  before_action :load_products, only: %i(index filter)

  def index; end

  def show
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "products.show.couldnt_found"
    redirect_to root_path
  end

  def filter
    @products = Product.by_active.stocking.includes(:images).filter(params[:filter], params[:order])
                       .paginate page: params[:page], per_page: Settings.paginate.product.per_page
    respond_to_format
  end

  private

  def load_products
    @q = Product.ransack params[:q]
    @products = @q.result.by_active.stocking.newest.includes(:images)
                  .paginate page: params[:page], per_page: Settings.paginate.product.per_page
  end

  def respond_to_format
    respond_to do |format|
      format.html{render "static_pages/home"}
      format.json {}
      format.js
    end
  end
end
