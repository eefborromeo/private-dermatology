class HomeController < ApplicationController
    skip_before_action :authenticate_user!
    before_action :check_user_info, if: :user_signed_in?
        
    def index
    end
end