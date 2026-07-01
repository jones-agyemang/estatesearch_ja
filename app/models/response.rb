class Response < ApplicationRecord
  belongs_to :lawyer, class_name: "Lawyer"
  belongs_to :question
  has_one :payment_request, dependent: :destroy

  validates :body, presence: true
  validates :fee, numericality: true
end
