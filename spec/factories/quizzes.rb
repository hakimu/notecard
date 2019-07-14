FactoryBot.define do
  factory :quiz do
    name 'My Quiz'
    difficulty 1
    questions 3
    association :user
  end
end
