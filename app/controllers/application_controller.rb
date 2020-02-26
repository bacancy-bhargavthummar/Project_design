class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    private

     def after_sign_in_path_for(resource)
        session[:current_user_email] = current_user.email
        return root_path
     end
    

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:user_name,:email, :password,:phone_no, :gender) }
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:user_name, :email, :password, :current_password, :phone_no, :gender) }
        end

end
