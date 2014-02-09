class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)
    resource.admin = 1
    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

  def after_sign_up_path_for(resource)
    user_path(current_user)
  end

  private

  def sign_up_params
    allow = [:email,
             :first_name,
             :nickname,
             :last_name,
             :password,
             :password_confirmation,
             :phone_number,
             :account_id,
             :admin]
    params.require(resource_name).permit(allow)
  end
end
