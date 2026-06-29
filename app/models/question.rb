class Question < ApplicationRecord
  validates :title, :body, :category, presence: true
end
