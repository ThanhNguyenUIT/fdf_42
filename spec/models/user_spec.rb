require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.build :user}
  subject{user}

  context "factories" do
    it "has a valid factory" do
      expect(user).to be_valid
    end
  end

  context "validates" do
    it "check the presence of name" do
      is_expected.to validate_presence_of(:name)
        .with_message(I18n.t "activerecord.errors.models.user.attributes.name.blank")
    end


    it "check the length of name" do
      is_expected.to validate_length_of(:name)
        .with_message(I18n.t "activerecord.errors.models.user.attributes.name.too_long")
    end

    it "check the presence of email" do
      is_expected.to validate_presence_of(:email)
        .with_message(I18n.t "activerecord.errors.models.user.attributes.email.blank")
    end

    it "check the length of email" do
      is_expected.to validate_length_of(:email)
        .with_message(I18n.t "activerecord.errors.models.user.attributes.email.too_long")
    end

    it "check email is unique" do
      is_expected.to validate_uniqueness_of(:email).case_insensitive
        .with_message(I18n.t "activerecord.errors.models.user.attributes.email.taken")
    end

    it "check the presence of password" do
      is_expected.to validate_presence_of(:password)
        .with_message(I18n.t "activerecord.errors.models.user.attributes.password.blank")
    end

    it "check the length of password" do
      is_expected.to validate_length_of(:password)
        .with_message(I18n.t "activerecord.errors.models.user.attributes.password.too_short")
    end

    it "check the presence of phone" do
      is_expected.to validate_presence_of(:phone)
        .with_message(I18n.t "activerecord.errors.models.user.attributes.phone.blank")
    end

    it "check the presence of address" do
      is_expected.to validate_presence_of(:address)
        .with_message(I18n.t "activerecord.errors.models.user.attributes.address.blank")
    end

    it "check the presence of city" do
      is_expected.to validate_presence_of(:city)
        .with_message(I18n.t "activerecord.errors.models.user.attributes.city.blank")
    end
  end

  context "associations" do
    it "should correctly identify the has_many orders" do
      is_expected.to have_many :orders
    end

    it "should correctly identify the has_many order_details through orders" do
      is_expected.to have_many(:order_details).through :orders
    end

    it "should correctly identify the has_many comments" do
      is_expected.to have_many :comments
    end

    it "should correctly identify the has_many ratings" do
      is_expected.to have_many :ratings
    end

    it "should correctly identify the has_many suggests" do
      is_expected.to have_many :suggests
    end
  end
end
