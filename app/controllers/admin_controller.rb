# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :logged_in_user, :require_admin

  def require_admin
    return if current_user.admin?
    flash[:danger] = t ".not_have_privilege"
    redirect_to root_path
  end
end
