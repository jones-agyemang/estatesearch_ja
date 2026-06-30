class ResponsesController < ApplicationController
  before_action :set_user
  before_action :set_question

  def new
    @response = @question.responses.new(lawyer_id: @user.id)

    render :new
  end

  def create
    @response = @user.responses.new(**response_params, question: @question)

    if @response.save
      redirect_to lawyers_dashboard_path, notice: "Successfully submitted response."
    else
      flash.now[:error] = "Response is invalid."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_question
    @question = Question.find(question_id)
  end

  def question_id
    params.expect(:question_id)
  end

  def response_params
    params.expect(response: [ :body, :fee ])
  end
end
