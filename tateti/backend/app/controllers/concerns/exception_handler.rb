module ExceptionHandler
  def handle_exception
    begin
      yield
    rescue ArgumentError => e
      render json: {error: e.message}, status: :bad_request
    rescue ActionController::ParameterMissing, ActiveRecord::RecordInvalid => e
      render json: {error: e.message}, status: :bad_request
    rescue ActiveRecord::RecordNotFound => e
      render json: {error: e.message}, status: :not_found
    rescue Game::NotYourTurnException => e
      render json: {error: e.message}, status: :forbidden
    rescue UnauthorizedException => e
      render json: {error: e.message}, status: :unauthorized
    end
  end

  def self.included(controller)
    controller.around_action :handle_exception
  end
end