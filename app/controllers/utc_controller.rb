class UtcController < ApplicationController
    before_action :active_drop
    before_action :non_active_drop
    
    before_action :find_user, only: [:user]
    respond_to :json

    def time
        render json: { time: '' + DateTime.now.utc.to_s }, status: :ok
    end

    def test
        render json: {
                            :"Active Drop" => {
                                "total_amount": 0,
                                "total_drop_locations": @active_drop.length,
                                "data": @active_drop
                            },
                            :"Non-Active Drop" => {
                                "total_amount": 0,
                                "total_drop_locations": @non_active_drop.length,
                                "data": @non_active_drop
                            }
                        }, status: :ok
    end

    def user
        if find_user.present?
            render json: { status_code: 200, data: find_user }, status: :ok
        else
            render json: { status_code: 404, message: 'User not found!' }, status: :ok
        end
        
    end


    private 
      
    def find_user
        User.find_by(email: params[:user][:email])
    end

    def active_drop
        @active_drop = Drop.where(is_active: true)
    end

    def non_active_drop
        @non_active_drop = Drop.where(is_active: false)
    end

end