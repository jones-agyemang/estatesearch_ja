class Response < ApplicationRecord
  belongs_to :lawyer, class_name: "Lawyer"
  belongs_to :question
  has_one :payment_request, dependent: :destroy

  validates :body, presence: true
  validates :fee, numericality: { greater_than_or_equal_to: 0 }
end
