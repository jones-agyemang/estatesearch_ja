class Lawyer < User
  has_many :responses, dependent: :destroy
  has_many :answered_questions, through: :responses, source: :question
  has_many :payment_requests, through: :responses
end
