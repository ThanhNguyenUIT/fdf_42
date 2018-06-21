# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: {processing: 0, ordered: 1, tranfering: 2, received: 3, cancelled: 4}

  belongs_to :user
  has_many :order_details, dependent: :destroy
end
