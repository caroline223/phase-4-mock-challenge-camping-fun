class CampersController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
   
    def index
        campers = Camper.all 
        render json: campers, status: :ok
    end

    def show 
        camper = find_camper
        if camper 
            render json: camper, serializer: CamperWithActivitiesSerializer, status: :ok
        else
            render_not_found_response
        end
    end

    def create
        camper = Camper.create!(camper_params)
        if camper.valid?
            render json: camper, status: :created
        else
            render_unprocessable_entity_response
        end

    end

    private

    def find_camper
       Camper.find_by_id(params[:id])
    end

    def camper_params
        params.permit(:name, :age)
    end

    def render_not_found_response
        render json: {error: "Camper not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
        render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
    end



end
