class GetuserinformationController < ApplicationController
    before_action :find_user, only: [:show]

    respond_to :json

        def show
            if @user.nil?
                render json: { status_code: 200, user: @user }, status: :ok
            else
                render json: { status_code: 404, message: 'Invalid User Id!' }, status: :ok
            end            
        end

        private
          
        def find_user
            @user = User.find_by_id(params[:id])
        end

end

