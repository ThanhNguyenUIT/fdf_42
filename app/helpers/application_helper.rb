# frozen_string_literal: true

module ApplicationHelper
  def full_title page_title
    base_title = t "layouts.application.base_title"
    page_title.blank? ? base_title : page_title + " | " + base_title
  end

  def show_badge number
    content_tag :span, number, class: "item_count"
  end

  def show_product_image product
    image_tag product.images.first.link, alt: product.name if product.images.present?
  end
end
