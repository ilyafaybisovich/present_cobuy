class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
    params.require(:user).permit :name, :email,
                                 :password, :password_confirmation
  end
end
