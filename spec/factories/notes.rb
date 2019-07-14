FactoryBot.define do
  factory :note do
    add_attribute(:method) {'puts'}
    code_sample 'puts "hello world"'
    definition 'outputs to the screen'
    language 'Ruby'
    difficulty 1
    association :user
  end
end
