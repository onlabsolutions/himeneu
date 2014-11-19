class ApplicationController < ActionController::Base
  before_filter :current_ability
  before_action :set_locale, :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  rescue_from CanCan::AccessDenied do |exception|
	flash[:error] = "Access denied."
	redirect_to root_url
  end

  def current_ability
  	@current_ability ||= Ability.new(current_user)
  end
end
