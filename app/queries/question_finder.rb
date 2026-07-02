# frozen_string_literal: true

class QuestionFinder
  DEFAULT_ORDER = { updated_at: :desc }

  def self.call(owner_id:)
    owner = User.find(owner_id)

    return ::Question.open.order(**DEFAULT_ORDER) if owner.is_a?(Lawyer)

    ::Question.where(user_id: owner_id).order(**DEFAULT_ORDER)
  rescue ActiveRecord::RecordNotFound
    Question.none
  end
end
