# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :orders, dependent: :destroy
  has_many :order_details, through: :orders
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :suggests, dependent: :destroy

  validates :email, presence: true, length: {maximum: Settings.email.length.maximum}
  validates :name, presence: true, length: {maximum: Settings.name.length.maximum}
  validates :phone, :address, :city, presence: true

  scope :activated, ->{where.not confirmed_at: nil}
end
