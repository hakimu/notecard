FactoryBot.define do
  factory :quiz do
    name 'My Quiz'
    association :user
  end
end
