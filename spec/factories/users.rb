FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    gender { Faker::Gender.binary_type }
    dob { Faker::Date.birthday(min_age: 1, max_age: 99) }
    contact_no { Faker::PhoneNumber.phone_number_with_country_code }
    email { Faker::Internet.email }
    address { Faker::Address.full_address }
    password { Faker::Internet.password(min_length: 6) }
    
    trait :admin do
      admin { true }
    end

    trait :confirmed do
      confirmed_at { 1.day.ago }
    end

    trait :incomplete_details do
      full_name { "Please Update" }
      gender { "Selecy" }
      dob { '0001-01-01 00:00:00' }
      contact_no { "Please Update" }
      address { "Please Update" }
    end

    factory :admin, traits: [:admin, :confirmed]
    factory :confirmed_user, traits: [:confirmed]
    factory :incomplete_user, traits: [:incomplete_details]
  end
end
