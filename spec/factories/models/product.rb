# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    id { Faker::Alphanumeric.alphanumeric(number: 10) }
    name { Faker::Restaurant.name }
    category { Faker::Restaurant.type.parameterize.underscore }
  end
end
