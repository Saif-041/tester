class UpdatepaymentController < ApplicationController
    before_action :find_user, only: [:update]

    def update
        if @user.nil?
            render json: { status_code: 404, message:"Invalid User Id!" }, status: :ok
        else
            @user.update(payment_status: params[:payment_status])
            if @user.payment_status == true
                @user.payment_date = DateTime.now.utc
                @user.role = "paid"
                render json: { status_code: 200, message: "Payment Status updated to true!"}, status: :ok
            else
                @user.role = "unpaid"
                render json: { status_code: 200, message: "Payment Status updated to false!"}, status: :ok
            end
            @user.save
        end
    end


    private

    def find_user
        @user = User.find_by_id(params[:id])
    end

end