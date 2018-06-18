# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "products.show.couldnt_found"
    redirect_to root_path
  end
end
