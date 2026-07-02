class Lawyers::DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_lawyer!

  def show
    @user = current_user
    @questions = QuestionFinder.call(owner_id: @user.id)
  end

  private

  def require_lawyer!
    return if current_user.is_a?(Lawyer)

    redirect_to users_dashboard_path, alert: "You must be a lawyer to access the lawyer dashboard."
  end
end
