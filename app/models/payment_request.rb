class PaymentRequest < ApplicationRecord
  belongs_to :lawyer, class_name: "Lawyer"
  belongs_to :response
end
