require "rails_helper"

RSpec.describe UsersController, type: :controller do
  login_user

  describe "#current_user" do
    it "should have a current_user" do
      expect(subject.current_user).to_not eq nil
    end
  end

  describe "GET show" do
    it "should render show template" do
      get :show
      expect(response).to render_template :show
    end
  end
end
