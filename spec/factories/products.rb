FactoryBot.define do
  factory :product do
    product_name { "Acne Cream" }
    product_desc { "Acne Cream is used to treat acne" }
    price { 200.0 }
    stocks { 5 }
    after(:build) do |product|
      product.product_image.attach(io: File.open(Rails.root.join('spec', 'support', 'acnecream.png')), filename: 'acnecream.png', content_type: 'image/png')
    end
  end
end
