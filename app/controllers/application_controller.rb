class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def after_sign_in_path_for(resource)
    current_user.admin ? admin_dashboard_index_path : root_path
  end

  def check_user_info
    if current_user.full_name == "Please Update" || current_user.gender == "Select" || current_user.dob == '2000-01-01 00:00:00' || current_user.address == "Please Update" || current_user.contact_no == "Please Update" 
      redirect_to edit_user_registration_path, alert: "Please update your information."
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :gender, :dob, :contact_no, :address, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :gender, :dob, :contact_no, :address, :email, :password, :password_confirmation])
  end
end
