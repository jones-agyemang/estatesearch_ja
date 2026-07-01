FactoryBot.define do
  factory :response do
    body { Faker::Lorem.sentence }
    fee { 125.50 }
    association :lawyer
    association :question
  end
end
