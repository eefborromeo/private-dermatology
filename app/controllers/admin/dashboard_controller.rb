class Admin::DashboardController < ApplicationController
    before_action :is_admin
    before_action :check_user_info, if: :user_signed_in?

    def index
      @today = AppointmentTransaction.where("appt_date = ?", "2022-08-24")
      @upcoming = AppointmentTransaction.where("appt_date > ?", "2022-08-24")
      @low = Product.where("stocks < ?", "60")
      @product_transactions = ProductTransaction.all
      @appt_transactions = AppointmentTransaction.all
    end
end
