# frozen_string_literal: true

class Admin::ProductsController < AdminController
  load_and_authorize_resource
  before_action :load_products, only: :index
  before_action :load_product, except: %i(index new create)
  before_action :load_orders_in_processing, only: :destroy

  def index; end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".create_success"
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update product_params
      flash[:success] = t ".edit_success"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      if @orders.present?
        @orders.find_each do |order|
          order.rejected!
          OrderMailer.reject_order(order).deliver_now
        end
      end
      @product.update! active: false
      flash[:success] = t ".delete_success"
      redirect_to admin_products_path
    end
  rescue StandardError
    flash[:danger] = t ".delete_failed"
    redirect_to admin_products_path
  end

  private

  def load_products
    @products = Product.stocking.by_active.newest
                       .paginate page: params[:page], per_page: Settings.paginate.product.per_page
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t ".couldnt_found"
    redirect_to root_path
  end

  def load_orders_in_processing
    @orders = Order.by_product_id(params[:id]).in_processing
  end

  def product_params
    params.require(:product).permit :category_id, :name, :information, :price, :quantity
  end
end
