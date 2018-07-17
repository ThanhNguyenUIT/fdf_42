require "rails_helper"

RSpec.describe Devise::RegistrationsController, type: :controller do
  before(:each) {@request.env["devise.mapping"] = Devise.mappings[:user]}

  describe "GET new" do
    it "should render new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    it "should create new user" do
      user_params = {user: FactoryBot.attributes_for(:user)}
      expect{post :create, params: user_params}.to change{User.count}.by 1
      expect(response).to redirect_to root_path
    end
  end

  describe "GET edit" do
    login_user

    it "should render edit template" do
      get :edit
      expect(response).to render_template :edit
    end
  end

  describe "PUT update" do
    login_user

    context "invalid attributes" do
      it "should render edit template" do
        user_params = {
          user: {
            name: Faker::Name.name
          }
        }
        put :update, params: user_params
        @user.reload
        expect(@user.name).to_not eq user_params[:user][:name]
        expect(response).to render_template :edit
      end
    end

    context "valid attributes" do
      it "should changes user attributes" do
        user_params = {user: FactoryBot.attributes_for(:user_update)}
        put :update, params: user_params
        @user.reload
        expect(@user.name).to eq user_params[:user][:name]
        expect(@user.phone).to eq user_params[:user][:phone]
        expect(@user.address).to eq user_params[:user][:address]
        expect(@user.city).to eq user_params[:user][:city]
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE destroy" do
    login_user

    it "should delete user" do
      expect{delete :destroy}.to change{User.count}.by -1
      expect(response).to redirect_to root_path
    end
  end
end
