class Response < ApplicationRecord
  belongs_to :lawyer
  belongs_to :question
end
