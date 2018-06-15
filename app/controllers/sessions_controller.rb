# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :load_user, only: :create

  def create
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == Settings.remember_me.checked ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        flash[:warning] = t "sessions.new.not_activated"
        redirect_to root_path
      end
    else
      flash.now[:danger] = t "sessions.new.invalid_email_password"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  def new; end

  private

  def load_user
    @user = User.find_by email: params[:session][:email].downcase
    return if @user
    flash[:danger] = t "shared.error_messages.couldnt_found"
    redirect_to login_path
  end
end
