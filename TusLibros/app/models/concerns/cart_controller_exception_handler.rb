module CartControllerExceptionHandler
  def handle_exception
    begin
      yield
    rescue CartSession::ExpiredException => e
      render json: {error: e.message}, status: :unprocessable_entity
    rescue ActionController::ParameterMissing, Cashier::EmptyCartException, ActiveRecord::RecordInvalid => e
      render json: {error: e.message}, status: :bad_request
    rescue ActiveRecord::RecordNotFound => e
      render json: {error: e.message}, status: :not_found
    rescue User::BadCredentialsException => e
      render json: {error: e.message}, status: :unauthorized
    end
  end

  def self.included(controller)
    controller.around_action :handle_exception
  end
end