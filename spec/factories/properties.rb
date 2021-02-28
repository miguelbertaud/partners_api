FactoryBot.define do
  factory :property do
    name { "MyString" }
    description { "MyText" }
    rental_price { "9.99" }
    status { 1 }
    tenant { nil }
  end
end
