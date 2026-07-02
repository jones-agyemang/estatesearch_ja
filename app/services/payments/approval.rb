module Payments
  class Approval
    Result = Data.define(:success?, :message)

    MESSAGE_MAP = {
        non_open_question: "Question has already been already answered or close.",
        payment_approved: "Payment approved and question marked as answered.",
        payment_already_made: "Question has already been already answered or close.",
        question_not_yours: "Question belongs to another user."
    }

    def initialize(user, question, response_id)
      @user = user
      @question = question
      @response_id = response_id
    end

    def self.call(...)
      new(...).call
    end

    def call
      return failure(MESSAGE_MAP.fetch(:non_open_question)) if !question.open?
      return failure(MESSAGE_MAP.fetch(:question_not_yours)) if question.user != user

      response = question.responses
                         .joins(:payment_request)
                         .find_by(id: response_id, paid: false)

      if response
        ActiveRecord::Base.transaction do
          response.update!(paid: true)
          question.answered!
        end

        success(MESSAGE_MAP.fetch(:payment_approved))
      else
        failure(MESSAGE_MAP.fetch(:payment_already_made))
      end
    end

    private

    attr_accessor :user, :question, :response_id

    def failure(message)
      Result.new(success?: false, message:)
    end

    def success(message)
      Result.new(success?: true, message:)
    end
  end
end
