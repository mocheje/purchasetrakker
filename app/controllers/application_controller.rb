class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  #check_authorization :unless => :devise_controller?
      rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or root_path
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end


  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_back_or root_path

  end

  def check_admin_role
    return if current_user.role?(:admin)
    flash[:warning] = "You need to be an admin to access this part of the application"
    redirect_to root_path
  end

  def active_admin_controller?
    self.is_a? ActiveAdmin::BaseController
  end
end
