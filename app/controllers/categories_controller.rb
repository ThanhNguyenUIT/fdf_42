# frozen_string_literal: true

class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    @category = Category.find_by id: params[:id]
    if @category
      @products = @category.products.by_active.stocking.includes(:images).filter params[:filter], params[:order]
    else
      flash[:danger] = t "categories.show.couldnt_found"
      redirect_to root_path
    end
  end
end
