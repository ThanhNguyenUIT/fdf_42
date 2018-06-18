# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: {processing: 1, ordered: 2, tranfering: 3, received: 4}

  belongs_to :user
  has_many :order_details, dependent: :destroy
end
