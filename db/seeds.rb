require 'faker'

Property.delete_all

10.times do |i|
  tenant = Tenant.create(name: "Player#{i}", email: "foo#{i}@bar.com", phone: "#{i}43535664")
end

Tenant.all.each do |t|
  t.properties.create(
    name: Faker::Address.street_name,
    description: Faker::Address.full_address ,
    rental_price: Faker::Number.decimal(l_digits: 4, r_digits: 2),
    status: ["available", "deleted", "published"].sample
  )
end
