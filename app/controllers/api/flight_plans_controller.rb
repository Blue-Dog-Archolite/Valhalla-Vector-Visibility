module Api
  class FlightPlansController < ApplicationController

    attr_reader :flight_plan
    before_action :fetch_flight_plan, only: [:show]

    def index
      @flight_plans = FlightPlan.all
    end

    def show
      @flight_plan
    end

    def create
      flight_plan = FlightPlan.new

      flight_plan.origin = flight_plan_params['origin']
      flight_plan.destination= flight_plan_params['destination']
      flight_plan.interval = flight_plan_params['interval'].to_i
      flight_plan.speed = flight_plan_params['speed'].to_i
      flight_plan.departure_time = Time.now

      if flight_plan.save
        render json: flight_plan
      else
        render_model_error(flight_plan)
      end
    end

    private

    def flight_plan_params
      # Tighten this up
      params.require(:flight_plan).permit!
    end

    def fetch_flight_plan
      @flight_plan = FlightPlan.find(params[:id])
    end
  end
end
