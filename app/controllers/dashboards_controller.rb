class DashboardsController < ApplicationController
  def show
    resolved_dashboard_path = after_sign_in_path_for(current_user)
    redirect_to resolved_dashboard_path
  end
end
