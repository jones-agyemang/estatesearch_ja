class DashboardPathResolver
  def self.call(user, routes)
    case user&.type&.downcase
    when "user", nil
      routes.users_dashboard_path
    when "lawyer"
      routes.lawyers_dashboard_path
    end
  end
end
