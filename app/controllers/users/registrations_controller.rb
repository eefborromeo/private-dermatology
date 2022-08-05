class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    if resource.provider == "google_oauth2" && resource.info_changed == false
      params.delete("current_password")
      resource.password = params['password']
      resource.info_changed = true
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

end