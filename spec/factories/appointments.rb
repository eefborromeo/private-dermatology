FactoryBot.define do
  factory :appointment do
    user { nil }
    slot { nil }
    reason { 'Acne treatment' }
    note { nil }
    status { 1 }
    interaction { 'online' }
  end
end
