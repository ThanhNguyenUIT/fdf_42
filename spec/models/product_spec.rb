require "rails_helper"

RSpec.describe Product, type: :model do
  before(:each) {FactoryBot.create :category}
  let(:product) {FactoryBot.build :product}
  subject {product}

  context "factories" do
    it "has a valid factory" do
      expect(product).to be_valid
    end
  end

  context "validates" do
    it "check the presence of name" do
      is_expected.to validate_presence_of(:name)
        .with_message(I18n.t "activerecord.errors.models.product.attributes.name.blank")
    end

    it "check the length of name" do
      is_expected.to validate_length_of(:name)
        .with_message(I18n.t "activerecord.errors.models.product.attributes.name.too_long")
    end

    it "check the presence of information" do
      is_expected.to validate_presence_of(:information)
        .with_message(I18n.t "activerecord.errors.models.product.attributes.information.blank")
    end

    it "check the length of information" do
      is_expected.to validate_length_of(:information)
        .with_message(I18n.t "activerecord.errors.models.product.attributes.information.too_long")
    end

    it "check the presence of price" do
      is_expected.to validate_presence_of(:price)
        .with_message(I18n.t "activerecord.errors.models.product.attributes.price.blank")
    end

    it "check the presence of quantity" do
      is_expected.to validate_presence_of(:quantity)
        .with_message(I18n.t "activerecord.errors.models.product.attributes.quantity.blank")
    end
  end

  context "associations" do
    it "should correctly identify the belongs_to category" do
      is_expected.to belong_to :category
    end

    it "should correctly identify the has_many order_details" do
      is_expected.to have_many :order_details
    end

    it "should correctly identify the has_many comments" do
      is_expected.to have_many :comments
    end

    it "should correctly identify the has_many ratings" do
      is_expected.to have_many :ratings
    end

    it "should correctly identify the has_many images" do
      is_expected.to have_many :images
    end
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:price).of_type :decimal}
    it {is_expected.to have_db_column(:information).of_type :text}
    it {is_expected.to have_db_column(:quantity).of_type :integer}
    it {is_expected.to have_db_column(:category_id).of_type :integer}
    it {is_expected.to have_db_column(:active).of_type :boolean}
  end
end
