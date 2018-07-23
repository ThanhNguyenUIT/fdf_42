require "faker"

FactoryBot.define do
  factory :category do
    id 1
    name {Faker::Food.dish}
  end
end
