class Users::DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @questions = @user.questions
  end
end
