class SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create
    self.resource = warden.authenticate!(sign_in_params)
    set_flash_message(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    if !session[:return_to].blank?
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
      respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :secret])
  end
end