# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "password_resets.create.email_sent"
      redirect_to root_path
    else
      flash.now[:danger] = t "password_resets.create.email_not_found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t("password_resets.update.cant_empty")
      render :edit
    elsif @user.update user_params
      log_in @user
      @user.update reset_digest: nil
      flash[:success] = t "password_resets.update.password_reseted"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "password_resets.password_reset_expired"
    redirect_to new_password_reset_path
  end

  def load_user
    @user = User.find_by email: params[:email]
    return if @user
    flash[:danger] = t "password_resets.couldnt_found", email: params[:email]
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def valid_user
    redirect_to root_path unless @user&.activated? && @user.authenticated?(:reset, params[:id])
  end
end
