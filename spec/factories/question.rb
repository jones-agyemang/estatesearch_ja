FactoryBot.define do
  factory :question do
    title { Faker::Lorem.sentence }
    body  { Faker::Lorem.sentences }
    category { Faker::Lorem.sentence }

    trait :answered do
      status { "answered" }
    end
  end
end
