class UtcController < ApplicationController
    before_action :find_user, only: [:user]
    respond_to :json

    def time
        render json: { time: '' + DateTime.now.utc.to_s[11,5] }, status: :ok
    #   render inline: "Some string to the client/user"
    end

    def user
        # resource = User.find_by(email: params[:user][:email])
        if find_user.present?
            render json: { data: find_user, status_code: 200 }, status: :ok
        else
            render json: { message: 'User not found!', status_code: 404 }, status: :ok
        end
        
    end


    private 
      
    def find_user
        User.find_by(email: params[:user][:email])
    end

end