class VotesController < ApplicationController
    before_action :find_user, only: [:castvote]

        def castvote
            if @user.nil?
                render json: {
                    status_code: 404,
                    message: "Invalid User Id"
                }, status: :ok
            else
                @ngo_id = Ngo.find_by_id(params[:ngo_id])
                if @ngo_id.nil?
                    render json: {
                        status_code: 404,
                        message: "Invalid Ngo Id"
                    }, status: :ok
                else
                    @poll_id_1 = Poll.find_by_ngo_id_1_id(params[:ngo_id])
                    @poll_id_2 = Poll.find_by_ngo_id_2_id(params[:ngo_id])
                    @poll_id_3 = Poll.find_by_ngo_id_3_id(params[:ngo_id])
                    @poll_id_4 = Poll.find_by_ngo_id_4_id(params[:ngo_id])
                    if @poll_id_1.present?
                        user_voted
                        @poll_id_1.ngo_1_votes = @poll_id_1.ngo_1_votes + 1
                        @poll_id_1.save
                        render json: {
                            status_code: 200,
                            message: "Voted for Ngo Id 1"
                        }, status: :ok
                    elsif @poll_id_2.present?
                        user_voted
                        @poll_id_2.ngo_2_votes = @poll_id_2.ngo_2_votes + 1
                        @poll_id_2.save
                        render json: {
                            status_code: 200, 
                            message: "Voted for Ngo Id 2"
                        }, status: :ok
                    elsif @poll_id_3.present?
                        user_voted
                        @poll_id_3.ngo_3_votes = @poll_id_3.ngo_3_votes + 1
                        @poll_id_3.save
                        render json: {
                            status_code: 200,
                            message: "Voted for Ngo Id 3"
                        }, status: :ok
                    elsif @poll_id_4.present?
                        user_voted
                        @poll_id_4.ngo_4_votes = @poll_id_4.ngo_4_votes + 1
                        @poll_id_4.save
                        render json: {
                            status_code: 200,
                            message: "Voted for Ngo Id 4"
                        }, status: :ok
                    else
                        render json: {
                            status_code: 404,
                            message: "No Ngo Id found in Poll"
                        }, status: :ok
                    end
                end
            end
        end


        private

        def user_voted
            @user.vote_casted=true
            @user.save
        end

        def find_user
            @user = User.find_by_id(params[:player_id])
        end

end