require "faker"

FactoryBot.define do
  factory :product do
    category_id 1
    name {Faker::Food.dish}
    information {Faker::Food.description}
    price {Faker::Number.number(2)}
    quantity {Faker::Number.between(1, 10)}
  end
end
