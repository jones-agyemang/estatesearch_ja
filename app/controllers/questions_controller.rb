class QuestionsController < ApplicationController
  before_action :set_question, only: [ :create ]

  def new
    @question = Question.new

    render :new
  end

  def create
    if @question.save
      flash[:alert] = "Query successfully raised!"
      redirect_to @question
    else
      flash[:error] = "Invalid query details."
      render :new, errors: @question.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_question
    @question = Question.new(question_params)
  end

  def question_params
    params.expect(question: [ :title, :body, :category ])
  end
end
