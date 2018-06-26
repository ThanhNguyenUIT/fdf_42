# frozen_string_literal: true

class Admin::CategoriesController < ApplicationController
  before_action :load_categories, only: :index
  before_action :load_category, except: %i(index new create)

  def index; end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".create_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] = t ".edit_success"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.update active: false
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to admin_categories_path
  end

  private

  def load_categories
    @categories = Category.by_active.newest
                          .paginate page: params[:page], per_page: Settings.paginate.category.per_page
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t ".couldnt_found"
    redirect_to root_path
  end

  def category_params
    params.require(:category).permit :name
  end
end
