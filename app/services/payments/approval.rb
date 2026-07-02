module Payments
  class Approval
    def initialize(user, question, response_id)
      @user = user
      @question = question
      @response_id = response_id
    end

    def self.call(...)
      new(...).call
    end

    def call
      result = Data.define(:success?, :message)

      response = question.responses
                        .joins(:payment_request)
                        .find_by(id: response_id, paid: false)

      if response
        response.update!(paid: true)
        question.answered!
        result.new(success?: true, message: "Payment approved and question marked as answered.")
      else
        result.new(success?: false, message: "Payment has already been made for this question.")
      end
    end

    private

    attr_accessor :user, :question, :response_id
  end
end
