class Lawyer < User
  has_many :responses, dependent: :destroy
  has_many :answered_questions, through: :responses, source: :question
end
