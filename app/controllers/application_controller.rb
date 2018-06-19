# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :load_categories

  private

  def load_categories
    @categories = Category.all
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "users.new.please_log_in"
    redirect_to login_path
  end
end
