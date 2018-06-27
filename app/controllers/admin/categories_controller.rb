# frozen_string_literal: true

class Admin::CategoriesController < AdminController
  before_action :load_categories, only: :index
  before_action :load_category, except: %i(index new create)
  before_action :load_products, only: :destroy

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
    ActiveRecord::Base.transaction do
      deactive_products @products if @products.present?
      @category.update! active: false
      flash[:success] = t ".delete_success"
      redirect_to admin_categories_path
    end
  rescue StandardError
    flash[:danger] = t ".delete_failed"
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

  def load_products
    @products = @category.products
  end

  def deactive_products products
    products.find_each do |product|
      product.update! active: false
      reject_orders_by_product product
    end
  end

  def reject_orders_by_product product
    orders = Order.by_product_id(product.id).in_processing
    return if orders.blank?
    orders.find_each do |order|
      order.rejected!
      OrderMailer.reject_order(order).deliver_now
    end
  end

  def category_params
    params.require(:category).permit :name
  end
end
