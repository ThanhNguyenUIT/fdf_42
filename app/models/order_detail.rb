# frozen_string_literal: true

class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :unit_price, presence: true
  validates :quantity, presence: true
end
