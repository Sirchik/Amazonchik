class ApplicationController < ActionController::Base
  # load_and_authorize_resource
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname])
    devise_parameter_sanitizer.for(:account_update) << :firstname << :lastname
    devise_parameter_sanitizer.for(:sign_up) << :firstname << :lastname
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
    # render :file => "#{Rails.root}/public/500.html", :status => 403, :layout => false
  end

end
