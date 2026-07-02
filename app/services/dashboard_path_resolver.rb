class DashboardPathResolver
  def self.call(user, routes)
    return routes.lawyers_dashboard_path if user&.is_a?(Lawyer)

    routes.users_dashboard_path
  end
end
