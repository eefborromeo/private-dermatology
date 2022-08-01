class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def after_sign_in_path_for(resource)
      current_user.admin ? admin_dashboard_index_path : root_path
    end
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :gender, :dob, :contact_no, :address, :email, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :gender, :dob, :contact_no, :address, :email, :password, :password_confirmation])
    end
end
