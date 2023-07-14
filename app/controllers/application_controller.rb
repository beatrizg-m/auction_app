# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def require_admin!
    return if current_user&.admin?

    redirect_to root_path, alert: 'Acesso negado. Você não tem permissão para acessar esta página.'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[cpf name])
  end
end
