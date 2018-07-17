require "faker"

FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    phone {Faker::PhoneNumber.phone_number}
    address {Faker::Address.street_address}
    city {Faker::Address.city}
    password "foobar"
    password_confirmation "foobar"
    confirmed_at Time.zone.now
    factory :user_update do
      current_password "foobar"
    end
  end
end
