# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, :load_user, only: :show
  load_and_authorize_resource

  def show; end

  private

  def load_user
    return if (@user = current_user)
    flash[:danger] = t "shared.error_messages.couldnt_found"
    redirect_to root_path
  end
end
