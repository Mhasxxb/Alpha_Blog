module Api
  class ApplicationController < ActionController::API
    before_action :authenticate_user!
    
    # rescue_from ActiveRecord::RecordNotFound do |e|
    #   render json: { error: e.message }, status: :not_found
    # end

    # rescue_from ActiveRecord::RecordInvalid do |e|
    #   render json: { error: e.record.errors }, status: :unprocessable_entity
    # end

    # Optional: authentication placeholder
    private

    def current_user
      # Replace with your auth logic (token/session)
      @current_user ||= User.first # temporary placeholder
    end
    private

    def authenticate_user!
      # logic to find user from token/session
      # render json: { error: "Unauthorized" }, status: :unauthorized unless current_user
    end
  end
end
