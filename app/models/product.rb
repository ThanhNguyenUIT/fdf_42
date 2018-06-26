# frozen_string_literal: true

class Product < ApplicationRecord
  attr_accessor :quantity_in_cart

  belongs_to :category
  has_many :order_details, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy

  scope :by_active, ->{where active: true}
  scope :order_by_desc, ->{order(created_at: :desc)}
  scope :stocking, ->{where "quantity > ?", Settings.quantity.zero}
  scope :load_product_by_ids, ->(product_ids){where id: product_ids}
end
