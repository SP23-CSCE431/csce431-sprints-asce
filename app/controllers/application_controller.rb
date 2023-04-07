class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :authenticate_admin!

  private

  # functions to check whether the user is exec/admin or not.
  def executive_officer?
    current_user && current_user.role_id == 1
  end
  helper_method :executive_officer?

  #get if user is a normal user
  def user?
    current_user && current_user.role_id == 3
  end
  helper_method :user?
  #current user is a variable to get current user
  def set_current_user
    # Use the user data from my profile page to set current user
    user = User.find_by(email: current_admin.email)
    @current_user = user if user.present?
  end

  def current_user
    @current_user
  end
end