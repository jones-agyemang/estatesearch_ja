class QuestionsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_user
  before_action :set_question, only: [ :create ]

  def index
    # TODO: Remove condition
    if @user.type&.downcase == "lawyer"
      @questions = Question.open
    else
      @questions = @user.questions
    end
  end

  def new
    @question = @user.questions.new

    render :new, status: :ok
  end

  def create
    if @question.save
      redirect_to users_dashboard_path, notice: "Query successfully raised!"
    else
      flash.now[:error] = "Invalid query details."
      render :new, status: :unprocessable_content
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_question
    @question = @user.questions.new(question_params)
  end

  def question_params
    params.expect(question: [ :title, :body, :category ])
  end
end
