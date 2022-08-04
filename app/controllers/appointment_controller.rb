class AppointmentController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index]
    before_action :check_user_info, if: :user_signed_in?

    def index
        
    end

    def show
    end

    def new
    end

    def create
    end

    def destroy
    end
    
end
