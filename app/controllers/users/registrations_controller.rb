class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  respond_to :json

    private
    
    def respond_with(resource, _opts = {})
      resource.persisted? ? register_success : register_failed
    end
    
    def register_success
      render json: { status_code: 200, message: 'Welcome! You have signed up successfully.', user: current_user }, status: :ok
    end
    
    def register_failed
      render json: { message: "Signed up failure.", status_code: 500 }, status: :ok
    end
    
end