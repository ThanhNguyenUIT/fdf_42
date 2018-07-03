# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i(create new show)
  before_action :load_user, except: %i(create new)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "users.new.check_email"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.index.user_delete"
    else
      flash[:danger] = t "shared.error_messages.delete_failed"
    end
    redirect_to users_path
  end

  def edit; end

  def new
    @user = User.new
  end

  def show
    redirect_to root_path unless @user.confirmed_at?
  end

  def update
    if @user.update user_params
      flash[:success] = t "users.edit.profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def correct_user
    redirect_to root_path unless current_user? @user
  end

  def load_user
    return if (@user = User.find_by id: params[:id])
    flash[:danger] = t "shared.error_messages.couldnt_found"
    redirect_to users_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
