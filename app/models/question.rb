class Question < ApplicationRecord
  enum :status, { open: 0, answered: 1, closed: 2 }, default: :open

  validates :title, :body, :category, presence: true
end
