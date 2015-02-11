class ConfirmationsController <  Devise::ConfirmationsController

  private
  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource_name, resource) #do the log in :)
    dashboard_path
  end

end
