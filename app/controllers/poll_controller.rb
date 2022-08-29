class PollController < ApplicationController
    before_action :find_user, only: [:update]
    before_action :get_poll, only: [:show]

    def create
        if @user.nil?
            render json: { status_code: 404, message: "Invalid User Id!"}, status: :ok
        else
            @ngo_id_1 = Ngo.find_by_id(params[:ngo_id_1])
            @ngo_id_2 = Ngo.find_by_id(params[:ngo_id_2])
            @ngo_id_3 = Ngo.find_by_id(params[:ngo_id_3])
            @ngo_id_4 = Ngo.find_by_id(params[:ngo_id_4])

            if @ngo_id_1.nil?
                render json: { status_code: 404, message: "Invalid Ngo Id 1!"}, status: :ok
            elsif @ngo_id_2.nil?
                    render json: { status_code: 404, message: "Invalid Ngo Id 2!"}, status: :ok
            elsif @ngo_id_3.nil?
                        render json: { status_code: 404, message: "Invalid Ngo Id 3!"}, status: :ok
            elsif @ngo_id_4.nil?
                            render json: { status_code: 404, message: "Invalid Ngo Id 4!"}, status: :ok
            else
                    @poll = Poll.create(
                                        user_id: params[:player_id],
                                        ngo_id_1_id: params[:ngo_id_1],
                                        ngo_id_2_id: params[:ngo_id_2],
                                        ngo_id_3_id: params[:ngo_id_3],
                                        ngo_id_4_id: params[:ngo_id_4],
                                        is_active: true,
                                        expire_time: 29.days.since.to_date
                                    )
                    render json: { status_code: 200, message:"Poll created successfully!", data: JSON.parse(@poll.to_json(:only => [:id,:user_id, :ngo_id_1_id,:ngo_id_2_id,:ngo_id_3_id,:ngo_id_4_id]))}, status: :ok
            end
        end
    end

    def show
        if @polls.present?
            @i = 0
                # # create array with name with 4 objects...
                @ngo1 = Ngo.find_by_id(@polls[@i].ngo_id_1_id)
                @ngo2 = Ngo.find_by_id(@polls[@i].ngo_id_2_id)
                @ngo3 = Ngo.find_by_id(@polls[@i].ngo_id_3_id)
                @ngo4 = Ngo.find_by_id(@polls[@i].ngo_id_4_id)
                @result = [
                            "Expire on": @polls[@i].expire_time,
                            { "Ngo_id": @polls[@i].ngo_id_1_id, "Name": @ngo1.name, "Votes": @polls[@i].ngo_1_votes},
                            { "Ngo_id": @polls[@i].ngo_id_2_id, "Name": @ngo2.name, "Votes": @polls[@i].ngo_2_votes},
                            { "Ngo_id": @polls[@i].ngo_id_3_id, "Name": @ngo3.name, "Votes": @polls[@i].ngo_3_votes},
                            { "Ngo_id": @polls[@i].ngo_id_4_id, "Name": @ngo4.name, "Votes": @polls[@i].ngo_4_votes}
                        ]
            render json: {status_code: 200, data: @result }, status: :ok
        else
            render json: { status_code: 404, message:"No Poll's available to vote"}, status: :ok
        end
    end


    private

    def find_user
        @user = User.find_by_id(params[:player_id])
    end

    def get_poll
        @polls = Poll.all
    end

end
