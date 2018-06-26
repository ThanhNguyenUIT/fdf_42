# frozen_string_literal: true

class Image < ApplicationRecord
  belongs_to :product

  validates :product_id, :link, presence: true
end
