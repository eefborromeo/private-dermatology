FactoryBot.define do
  factory :product do
    product_name { "MyString" }
    product_desc { "MyText" }
    price { 1 }
    stocks { 1 }
  end
end
