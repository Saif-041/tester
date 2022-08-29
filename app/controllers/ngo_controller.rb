class NgoController < ApplicationController
    before_action :get_ngos, only: [:index]

    def index            
        if @ngos.present?
            @ngo = @ngos.to_json(:only => [:id, :name])
            render json: {status_code: 200, data: JSON.parse(@ngo)}, status: :ok
        else
            render json: { status_code: 404, message:"No Ngo's available"}, status: :ok
        end
    end


    private

    def get_ngos
        @ngos = Ngo.all 
    end

end