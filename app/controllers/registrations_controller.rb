class RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token, :only => :create
  before_action :configure_permitted_parameters

  def create
    build_resource({
      email: sign_up_params[:email],
      first: sign_up_params[:first],
      last: sign_up_params[:last]
    })

    secret = Secret.find_by(encrypted_secret: sign_up_params[:code])  
    if secret && secret.user.nil?
      resource.secret = secret
    end 
    
    resource_saved = resource.save
    yield resource if block_given?
    if resource.persisted?
      resource.add_role 'user'
      set_flash_message! :info, :signed_up
      sign_in(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      respond_with resource
    end
  end
  
  protected

  def configure_permitted_parameters
    added_attrs = [:email, :first, :last, :code]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
  end
end