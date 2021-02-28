FactoryBot.define do
  factory :property do
    name { Faker::Address.street_name }
    description { Faker::Address.full_address }
    rental_price { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    status { 1 }
    tenant { nil }
  end
end
