# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def build_resource(hash = {})
    self.resource = resource_class.new_with_session(hash, session)
  end

  private

  def resource_class
    params[:user_type] == "lawyer" ? Lawyer : User
  end
end
