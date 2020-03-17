class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	def after_sign_in_path_for(resource)
		case resource
		when Admin
			admin_root_path
		when User
			root_path
		end
	end

	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :firstname_kana, :lastname_kana, :email, :password, :postal, :address, :telephone])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :password])
	end
end

