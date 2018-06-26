# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.name.length.maximum}

  scope :newest, ->{order created_at: :desc}
  scope :by_active, ->{where active: true}
end
