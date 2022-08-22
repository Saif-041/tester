class Users::SessionsController < Devise::SessionsController
    before_action :authenticate_user!
    respond_to :json

    def create
      #byebug
      #self.resource = warden.authenticate!(auth_options)
      self.resource = User.find_by(email: params[:user][:email])
      resource.present? ? login_user : show_invalid_message
        
      # set_flash_message!(:notice, :signed_in)
      # sign_in(resource_name, resource)
      # yield resource if block_given?
      # respond_with resource, location: after_sign_in_path_for(resource)
    end

    private
    
    def verify_signed_out_user
      self.resource = User.find_by(email: params[:user][:email])
      if !resource.present?
        render json: { message: 'User Does not exits!', status_code: 401 }, status: :ok
      elsif all_signed_out?
        set_flash_message! :notice, :already_signed_out
  
        respond_to_on_destroy
      end
                    # byebug
                    # self.resource = User.find_by(email: params[:user][:email])

                    # if !resource.present?
                    #   render json: { message: 'User Does not exits!', status: 401 }, status: :ok
                    # end

                    # if all_signed_out?
                    #   set_flash_message! :notice, :already_signed_out
                      
                    #   respond_to_on_destroy
                    # end

                    # if !all_signed_out?
                    #   render json: { message: 'User Already Logout!', status: 500 }, status: :ok
                    #   # respond_to_on_destroy
                    # end
        #respond_to_on_destroy
    end

    def login_user
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end

    def show_invalid_message
      render json: { message: 'Invalid email or password!', status_code: 500}, status: :ok
    end

    def respond_with(resource, _opts = {})
      render json: { data: { message: 'Login successfully!', status_code: 200, token: current_token } }, status: :ok
    end
    
    def respond_to_on_destroy
      current_user.present? ? log_out_failure : log_out_success
    end
    
    def log_out_success
      render json: { message: "Logged out successfully!", status_code: 200 }, status: :ok
    end
    
    def log_out_failure
      render json: { message: "Logged out failure.", status_code: 500}, status: :ok
    end
    
    def current_token
      request.env['warden-jwt_auth.token']
    end

end