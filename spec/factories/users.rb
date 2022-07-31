FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    gender { Faker::Gender.binary_type }
    dob { Faker::Date.birthday(min_age: 1, max_age: 99) }
    contact_no { Faker::PhoneNumber.phone_number_with_country_code }
    email { Faker::Internet.email }
    address { Faker::Address.full_address }

    trait :admin do
      admin { true }
    end

    trait :confirmed do
      confirmed_at { 1.day.ago }
    end

    factory :admin, traits: [:admin, :confirmed]
    factory :confirmed_user, traits: [:confirmed]
  end
end
