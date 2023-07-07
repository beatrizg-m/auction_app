class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def require_admin!
    unless current_user && current_user.admin?
      redirect_to root_path, alert: 'Acesso negado. Você não tem permissão para acessar esta página.'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:cpf, :name])
  end
end
