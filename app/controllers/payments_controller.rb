class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_question

  def approve_payment
    result = Payments::Approval.call(@user, @question, response_id)

    respond_to do |format|
      if result.success?
        @question.reload

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("flash", partial: "users/dashboards/shared/flash", locals: { notice: result.message, alert: nil }),
            turbo_stream.replace(ActionView::RecordIdentifier.dom_id(@question), partial: "users/dashboards/question", locals: { question: @question })
          ]
        end

        format.html { redirect_to users_dashboard_path, notice: result.message }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "flash",
            partial: "users/dashboards/shared/flash",
            locals: { notice: nil, alert: result.message }
          )
        end

        format.html { redirect_to users_dashboard_path, alert: result.message }
      end
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
