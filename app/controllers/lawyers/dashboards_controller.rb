class Lawyers::DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @questions = Question.open
  end
end
