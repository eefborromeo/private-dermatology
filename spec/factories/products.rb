FactoryBot.define do
  factory :product do
    product_name { "Acne Cream" }
    product_desc { "Acne Cream is used to treat acne" }
    price { 200.0 }
    stocks { 5 }
  end
end
