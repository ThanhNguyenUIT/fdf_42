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

  def index_count_page counter, page, max_per
    counter + couter_page_list(page, max_per)
  end

  def couter_page_list page, per
    if page.blank?
      Settings.number.one
    else
      (page.to_i - Settings.number.one) * per + Settings.number.one
    end
  end
end
