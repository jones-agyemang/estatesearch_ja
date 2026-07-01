class ResponsesController < ApplicationController
  before_action :set_lawyer
  before_action :set_question

  def new
    @response = @question.responses.new(lawyer_id: @lawyer.id)

    render :new
  end

  def create
    @response = @lawyer.responses.new(**response_params, question: @question)

    if create_response_with_payment_request
      redirect_to lawyers_dashboard_path, notice: "Successfully submitted response."
    else
      flash.now[:error] = "Response is invalid."
      render :new, status: :unprocessable_entity
    end
  end

  def approve_payment
    response = @question.responses.joins(:payment_request).find_by(paid: false)

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

  def set_lawyer
    @lawyer = current_user
  end

  def set_question
    @question = Question.find(params.expect(:question_id))
  end

  def response_params
    params.expect(response: [ :body, :fee ])
  end

  def create_response_with_payment_request
    ActiveRecord::Base.transaction do
      @response.save!
      @response.create_payment_request!(lawyer: @lawyer)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end
end
