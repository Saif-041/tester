class DropController < ApplicationController
    before_action :find_user, only: [:show, :collect]
    before_action :get_drop, only: [:show]

    def show
        if @user.nil?  
            render json: {message: "Invalid User Id!", status: 404 }, status: :ok
        else
            if !@drop.present?  || @user.city.nil?
                render json: { status_code: 404, message: "No Drops found in your city"}, status: :ok  
            else
                # @result = [
                #             data: [
                #             { "longitude": @drop.longitude, "latitude": @drop.latitude},
                #             ]
                #         ]
                render json: { "longitude": @drop.longitude, "latitude": @drop.latitude }, status: :ok
            end
        end
    end

    def collect
        @drop = Drop.find_by_id(params[:drop_id])
        if @user.nil?
            render json: {
                message: "Invalid User Id",
                status: 404
            }, status: :ok
        elsif @drop.nil?
            render json: {
                message: "Invalid Drop Id",
                    status: 404
                }, status: :ok
        else
            if @user.payment_status == false
                render json: {
                    message: "Please Subscribe to Collect Drop.",
                    status: 401
                }, status: :ok
            elsif @drop.is_active == true
                @user.total_collection = @user.total_collection + @drop.reward_amount
                @user.save
                @drop.is_active = false
                @drop.save
                render json: {
                    message: "Drop Collected!  #{@drop.reward_amount}$ added to User id: #{@user.id}",
                    status: 200
                }, status: :ok
            else
                render json: {
                    message: "Drop already Collected!",
                    status: 401
                }, status: :ok
            end
        end
    end

    def city
      @re = []
      # @citi = CS.states(params[:country]).keys.flat_map {
      #     |state| @re.concat(CS.cities(state, params[:country]))
      # }
      @prov = CS.states(params[:country]).map {
          |k,state|
          if params[:province] == state
              @re=k
          end
      }
              # render json: { data: @re.sort! }, status: :ok
      @cities = CS.cities(@re, params[:country])
      render json: { data: @cities }, status: :ok
  end
  
    def province
        @provinces = []
        @states = CS.states(params[:country]).map {
            |k,state| @provinces.append(state)
        }
        render json: { data: @provinces }, status: :ok
        # @provinces = CS.states(params[:country])
        #     render json: { data: @provinces }, status: :ok
    end

    def import
        Drop.import(params[:file])
        redirect_to admin_drops_path, notice: "drops added"
    end


    

    private

    def find_user
        @user = User.find_by_id(params[:id])
    end

    def get_drop
        @drop = Drop.where(city: @user.city)
    end

end