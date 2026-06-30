class Question < ApplicationRecord
  belongs_to :user
  has_many :responses, dependent: :destroy
  has_many :lawyers, through: :responses

  enum :status, { open: 0, answered: 1, closed: 2 }, default: :open

  validates :title, :body, :category, presence: true
end
