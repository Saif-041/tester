class UtcController < ApplicationController
    before_action :active_drop
    before_action :non_active_drop
    
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

    private 
    
    def active_drop
        @active_drop = Drop.where(is_active: true)
    end

    def non_active_drop
        @non_active_drop = Drop.where(is_active: false)
    end

end