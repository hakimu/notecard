require 'factory_bot'
FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "hakimu_#{n}" }
    sequence(:email) { |n| "h_#{n}@example.com" }
    password 'password'
  end
end
