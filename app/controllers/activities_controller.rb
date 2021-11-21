class ActivitiesController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index 
        activties = Activity.all 
        render json: activties
    end

    def show
        activity = find_activities
        if activity
         render json: activity, status: :ok
        else
            render_not_found_response
        end
    end

    def destroy
        activity = find_activity
        if activity
            activity.destroy
            signups = Signup.find_by(activity_id: params[:id])
            signups.destroy
            head :no_content
        else
            render_not_found_response
        end   
    end

    private

    def find_activity
        Activity.find_by_id(params[:id])
    end

    def render_not_found_response
        render json: {error: "Activity not found"}, status: :not_found 
    end


end
