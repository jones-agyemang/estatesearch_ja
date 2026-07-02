class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_question

  def approve_payment
    result = Payments::Approval.call(@user, @question, response_id)

    if result.success?
      redirect_to users_dashboard_path, notice: result.message
    else
      redirect_to users_dashboard_path, alert: result.message
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
