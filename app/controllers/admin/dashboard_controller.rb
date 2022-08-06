class Admin::DashboardController < ApplicationController
    before_action :is_admin
    before_action :check_user_info, if: :user_signed_in?

    def index

    end
end
