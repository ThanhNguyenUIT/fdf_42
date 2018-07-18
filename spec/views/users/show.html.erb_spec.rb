require "rails_helper"

RSpec.describe "users/show" do
  let(:user) {FactoryBot.build :user}
  subject{user}

  it "displays the user" do
    assign :user, user
    render
    expect(rendered).to match /#{user.name}/
  end

  it "displays the given text" do
    render plain: "This is directly rendered"
    expect(rendered).to match /directly rendered/
  end

  it "matches the Rails environment by using symbols for keys" do
    [:controller, :action].each {|k| expect(controller.request.path_parameters.keys).to include k}
  end

  it "has a request.fullpath that is defined" do
    expect(controller.request.fullpath).to eq user_path
  end

  it "infers the controller path" do
    expect(controller.request.path_parameters[:controller]).to eq "users"
    expect(controller.controller_path).to eq "users"
  end

  it "infers the controller action" do
    expect(controller.request.path_parameters[:action]).to eq "show"
  end
end
