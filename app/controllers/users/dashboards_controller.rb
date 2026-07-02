class Users::DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @questions = QuestionFinder.call(owner_id: @user.id)
  end
end
