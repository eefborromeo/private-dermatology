class UsersController < ApplicationController
  before_action :check_user_info, if: :user_signed_in?
  def index
    @users = User.all
  end
end
