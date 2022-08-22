class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private
    
    def respond_with(resource, _opts = {})
    byebug
      resource.persisted? ? register_success : register_failed
    end
    
    def register_success
      render json: { message: 'Signed up.', status_code: 200 }, status: :ok
    end
    
    def register_failed
      render json: { message: "Signed up failure.", status_code: 500 }, status: :ok
    end
    
end