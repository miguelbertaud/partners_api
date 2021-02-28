FactoryBot.define do
  factory :tenant do
    name { Faker::Name.unique.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
  end
end
