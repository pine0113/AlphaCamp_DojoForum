class Admin::BaseController < ApplicationController
  # before_action :authenticate_admin

  private

  def authenticate_admin
    return false if current_user.admin?
    flash[:alert] = 'Not allow!'
    redirect_to root_path
  end
end
