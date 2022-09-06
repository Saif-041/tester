class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!
  respond_to :json

  def create
    self.resource = User.find_by(email: params[:user][:email])
    resource.present? ? login_user : show_invalid_message
  end

  private
  def login_user
    if self.resource.valid_password?(params[:user][:password])
      self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
    else
      render json: { message: 'Invalid Password!', status: 500}, status: :ok
    end
  end

  def show_invalid_message
    render json: { message: 'No User Exist with this Email!', status: 500}, status: :ok
  end

  def respond_with(resource, _opts = {})
    render json: { data: { message: 'Login successfully!', status: 200, token: current_token } }, status: :ok
  end

  def respond_to_on_destroy
    current_user.present? ? log_out_failure : log_out_success
  end

  def log_out_success
    render json: { message: "Logged out successfully!", status: 200 }, status: :ok
  end

  def log_out_failure
    render json: { message: "Logged out failure.", status: 500}, status: :ok
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end









   



Users::SessionsController < Devise::SessionsController
#     before_action :authenticate_user!
#     respond_to :json

#     def create
#       self.resource = User.find_by(email: params[:user][:email])
#       resource.present? ? login_user : show_invalid_message       
#     end

#     private
    
#     def verify_signed_out_user
#       self.resource = User.find_by(email: params[:user][:email])
#       if !resource.present?
#         render json: { status_code: 404, message: 'User Does not exits!' }, status: :ok
#       elsif all_signed_out?
#         set_flash_message! :notice, :already_signed_out  
#         respond_to_on_destroy
#       end
#     end

#     def login_user
#       if self.resource.valid_password?(params[:user][:password])
#          self.resource = warden.authenticate!(auth_options)
#         set_flash_message!(:notice, :signed_in)
#         sign_in(resource_name, resource)
#         yield resource if block_given?
#         respond_with resource, location: after_sign_in_path_for(resource)
#       else
#         render json: { status_code: 500, message: 'Invalid Password!' }, status: :ok
#       end
#     end

#     def show_invalid_message
#       render json: { status_code: 404, message: 'No User Exist with this Email!' }, status: :ok
#     end

#     def respond_with(resource, _opts = {})
#       render json: { data: { status_code: 200, message: 'Login successfully!', token: current_token } }, status: :ok
#     end
    
#     def respond_to_on_destroy
#       current_user.present? ? log_out_failure : log_out_success
#     end
    
#     def log_out_success
#       render json: { status_code: 200, message: "Logged out successfully!" }, status: :ok
#     end
    
#     def log_out_failure
#       render json: { status_code: 500, message: "Logged out failure." }, status: :ok
#     end
    
#     def current_token
#       request.env['warden-jwt_auth.token']
#     end

# end