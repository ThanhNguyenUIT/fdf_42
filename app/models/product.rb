# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  scope :load_product, ->{where "quantity > ?", Settings.quantity.zero}
end
