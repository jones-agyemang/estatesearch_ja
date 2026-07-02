# frozen_string_literal: true

class QuestionFinder
  def self.call(owner_id:)
    owner = User.find(owner_id)

    return ::Question.open if owner.is_a?(Lawyer)

    ::Question.where(user_id: owner_id)
  rescue ActiveRecord::RecordNotFound
    Question.none
  end
end
