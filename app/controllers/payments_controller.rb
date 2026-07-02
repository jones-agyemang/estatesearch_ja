class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_question

  def approve_payment
    response = @question.responses
                        .joins(:payment_request)
                        .find_by(id: response_id, paid: false)

    if response
      ActiveRecord::Base.transaction do
        response.update!(paid: true)
        @question.answered!
      end

      redirect_to users_dashboard_path, notice: "Payment approved and question marked as answered."
    else
      redirect_to users_dashboard_path, alert: "No unpaid response found for this question."
    end
  end

  private

  def set_user
    @user = current_user
  end

  def response_id
    params.expect(:id)
  end

  def set_question
    @question = Question.find(params.expect(:question_id))
  end
end
