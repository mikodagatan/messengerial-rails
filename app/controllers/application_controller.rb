class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :in_form?, :in_show?

  def in_form?
    controller_name == 'registrations' ||
    controller_name == 'sessions' ||
    params[:action] == 'new' ||
    params[:action] == 'edit'
  end

  def in_show?
    params[:action] == 'show'
  end
end
