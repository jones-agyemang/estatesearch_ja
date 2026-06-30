class QuestionsController < ApplicationController
  before_action :set_user
  before_action :set_question, only: [ :create ]

  def index
    @questions = Question.all
  end

  def new
    @question = @user.questions.new

    render :new
  end

  def create
    if @question.save
      redirect_to questions_path, notice: "Query successfully raised!"
    else
      flash.now[:error] = "Invalid query details."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_or_create_by!(first_name: "John", last_name: "Pearson", email: "john.pearson@example.com")
  end

  def set_question
    @question = @user.questions.new(question_params)
  end

  def question_params
    params.expect(question: [ :title, :body, :category ])
  end
end
