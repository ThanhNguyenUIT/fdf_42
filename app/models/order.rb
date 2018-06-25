# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: {processing: 0, ordered: 1, rejected: 2, cancelled: 3}

  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  validates :receiver, presence: true, length: {maximum: Settings.name.length.maximum}
  validates :phone, :address, presence: true

  scope :order_by_desc, ->{order(created_at: :desc)}
  scope :by_product_id, ->(product_id) do
    joins(:order_details).where("order_details.product_id = ?", product_id)
  end
  scope :in_processing, ->{where status: :processing}
end
