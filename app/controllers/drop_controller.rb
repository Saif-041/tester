class DropController < ApplicationController
    before_action :find_user, only: [:show]
    before_action :get_drop, only: [:show]

    def show
        if @user.nil?  
            render json: {message: "Invalid User Id!", status: 404 }, status: :ok
        else
            if !@drop.present?  || @user.city.nil?
                render json: { status_code: 404, message: "No Drops found in your city"}, status: :ok  
            else
                render json: {status_code: 200, data: @drop }, status: :ok
            end
        end
    end
    

    private

    def find_user
        @user = User.find_by_id(params[:id])
    end

    def get_drop
        @drop = Drop.where(city: @user.city)
    end

end