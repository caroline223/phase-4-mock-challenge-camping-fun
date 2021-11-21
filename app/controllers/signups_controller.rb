class SignupsController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index 
        signups = Signup.all 
        render json: signups, status: :ok
    end

    def show 
        signup = find_signup
        if signup
            render json: signup, status: :ok
        else
            render_not_found_response
        end
    end

    def create
        signup = Signup.create!(signup_params)
        if signup.valid?
            render json: signup.activity, status: :created
        else
            render_unprocessable_entity_response
        end

    end

    private

    def find_signup
        Signup.find_by_id(params[:id])
    end

    def signup_params
        params.permit(:id, :camper_id, :activity_id, :time)
    end


    def render_unprocessable_entity_response(exception)
        render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
    end

    def render_not_found_response
        render json: {error: "Signup not found."}, status: :not_found
    end

    
end
