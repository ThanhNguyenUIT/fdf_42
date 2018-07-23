require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.build :user}
  subject{user}

  context "factories" do
    it "has a valid factory" do
      expect(user).to be_valid
    end
  end

  context "user is invalid" do
    let(:user_invalid_email) {FactoryBot.build :user_invalid_email}
    it "invalid email" do
      expect(user_invalid_email).not_to be_valid
    end
  end

  context "when email is not valid" do
    before {subject.email = ""}
    it {is_expected.not_to be_valid}
  end

  context "when email is too long" do
    before {subject.email = Faker::Internet.email(Faker::Lorem.characters(256))}
    it {is_expected.not_to be_valid}
  end

  context "when pasword is not valid" do
    before {subject.email = ""}
    it {is_expected.not_to be_valid}
  end

  context "when password is too short" do
    before {subject.email = Faker::Lorem.characters(5)}
    it {is_expected.not_to be_valid}
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

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:phone).of_type :string}
    it {is_expected.to have_db_column(:address).of_type :string}
    it {is_expected.to have_db_column(:city).of_type :string}
    it {is_expected.to have_db_column(:email).of_type :string}
    it {is_expected.to have_db_column(:admin).of_type :boolean}
    it {is_expected.to have_db_column(:encrypted_password).of_type :string}
    it {is_expected.to have_db_column(:confirmation_token).of_type :string}
    it {is_expected.to have_db_column(:reset_password_token).of_type :string}
    it {is_expected.to have_db_column(:remember_created_at).of_type :datetime}
  end

  context "#activated" do
    let(:user1) {FactoryBot.create :user}
    let(:user2) {FactoryBot.create :user_not_activated}
    let(:user3) {FactoryBot.create :user}

    it "list user activated not match" do
      expect(User.activated).not_to match_array([user1, user2, user3])
    end

    it "list user activated match" do
      expect(User.activated).to match_array([user1, user3])
    end
  end
end
