class ApplicationController < ActionController::Base
  include ActionController::Helpers
  include ActionController::Flash
  include ActionView::Helpers::UrlHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :unlogged_redirect

  helper_method :in_form?, :in_show?, :in_report?

  def in_form?
    controller_name == 'registrations' ||
    controller_name == 'sessions' ||
    params[:action] == 'new' ||
    params[:action] == 'edit'
  end

  def in_show?
    params[:controller] != 'pages' &&
    params[:controller] != 'reports' &&
    (params[:action] != 'new' &&
    params[:action] != 'edit')
  end

  def in_report?
    controller_name == 'reports'
  end

  def unlogged_redirect
    if !current_page?(root_url) && user_signed_in? == false && !(controller_name == 'registrations' ||
    controller_name == 'sessions')
      redirect_to root_url
    end
  end


  protected

  def configure_permitted_parameters
    attrs = [:first_name,
            :last_name,
            :contact_number,
            :email,
            :password,
            :password_confirmation,
            :current_password
          ]
    devise_parameter_sanitizer.permit :sign_up, keys: attrs
    devise_parameter_sanitizer.permit :account_update, keys: attrs
  end
end
