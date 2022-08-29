class FeedbackController < ApplicationController
    before_action :find_user, only: [:create]
    before_action :find_feedback, only: [:show, :update]
    before_action :get_feedbacks, only: [:index, :update]

    def index
        if @feedbacks.present?
            render json: {status_code: 200, data: @feedbacks}, status: :ok
        else
            render json: { status_code: 404, message:"No Feedback yet!"}, status: :ok
        end
    end 
    
    def show
        render json: { status_code: 200, data: @feedback}, status: :ok
    end 
    
    def create
        if @user.present?
            @feedback = Feedback.create(
                user_id: params[:id],
                message_heading: params[:message_heading],
                message_details: params[:message_details]
            )
            render json: { status_code: 200, data: @feedback}, status: :ok
        else
            render json: { status_code: 404, message: "Invalid User Id!"}, status: :ok
        end
    end

    def update
        @feedback.is_resolved = true
        @feedback.save!
        render json: { status_code: 200, data: @feedbacks}, status: :ok
    end 


    private

    def find_user
        @user = User.find_by_id(params[:id])
    end

    def find_feedback
        @feedback = Feedback.find(params[:id])
    end
    
    def get_feedbacks
        @feedbacks = Feedback.all 
    end
    
end