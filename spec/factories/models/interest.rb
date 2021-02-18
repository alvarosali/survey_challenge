# frozen_string_literal: true

FactoryBot.define do
  factory :interest do
    product_id { create(:product).id }
    user_id { Faker::Alphanumeric.alphanumeric(number: 10) }
    score { Faker::Number.within(range: 1..10) }
  end
end
