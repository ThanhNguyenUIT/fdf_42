require "rails_helper"

RSpec.describe "devise/registrations/edit" do
  it "displays the given text" do
    render plain: "This is directly rendered"
    expect(rendered).to match /directly rendered/
  end

  it "matches the Rails environment by using symbols for keys" do
    [:controller, :action].each {|k| expect(controller.request.path_parameters.keys).to include k}
  end

  it "has a request.fullpath that is defined" do
    expect(controller.request.fullpath).to eq edit_user_registration_path
  end

  it "infers the controller path" do
    expect(controller.request.path_parameters[:controller]).to eq "devise/registrations"
    expect(controller.controller_path).to eq "devise/registrations"
  end

  it "infers the controller action" do
    expect(controller.request.path_parameters[:action]).to eq "edit"
  end
end
