module Devise::RegistrationsHelper
  def registration_path(resource, routes)
    return routes.lawyer_registration_path if resource.is_a?(Lawyer)

    routes.user_registration_path
  end

  def get_resource_name(resource)
    resource.class.name.humanize
  end
end
