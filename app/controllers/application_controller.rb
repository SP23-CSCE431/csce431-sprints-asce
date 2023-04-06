class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :authenticate_admin!

  private

  def executive_officer?
    current_user && current_user.role_id == 1
  end
  helper_method :executive_officer?

  def set_current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def current_user
    @current_user
  end
end