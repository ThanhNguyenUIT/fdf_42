# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: {processing: 0, ordered: 1, tranfering: 2, received: 3, cancelled: 4}

  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  validates :receiver, presence: true, length: {maximum: Settings.name.length.maximum}
  validates :phone, :address, presence: true

  scope :order_by_desc, ->{order(created_at: :desc)}
end
