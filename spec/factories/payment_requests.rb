FactoryBot.define do
  factory :payment_request do
    association :lawyer
    association :response
  end
end
