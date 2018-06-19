User.create!(
  name: "Thanh Nguyen",
  email: "thanhnt.uit@gmail.com",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true,
  address: "Linh Trung, Thu Duc",
  city: "Ho Chi Minh City",
  phone: "01686329452",
  activated: true,
  activated_at: Time.zone.now)
5.times do
  Category.create!(name: Faker::Name.name)
end
50.times do
  category_ids = Category.all.pluck(:id)
  name = Faker::Food.dish
  information = Faker::Food.description
  price = Faker::Number.number(2)
  quantity = Faker::Number.between(1, 10)
  Product.create!(
    category_id: category_ids[rand(category_ids.size)],
    name: name,
    information: information,
    price: price,
    quantity: quantity)
end
50.times do |id|
  product_ids = Product.all.pluck(:id)
  link = Faker::Avatar.image
  Image.create!(
    link: link,
    product_id: product_ids[id])
end
