# frozen_string_literal: true

class Admin::StaticPagesController < AdminController
  authorize_resource class: false

  def home; end
end
