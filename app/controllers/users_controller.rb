# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :load_user, only: :show

  def show
    redirect_to root_path unless @user.confirmed_at?
  end

  private

  def load_user
    return if (@user = current_user)
    flash[:danger] = t "shared.error_messages.couldnt_found"
    redirect_to root_path
  end
end
