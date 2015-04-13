module Api
  class FlightPlansController < ApplicationController
    attr_reader :flight_plan
    before_action :fetch_flight_plan, only: [:show]

    def index
      @flight_plans = FlightPlan.all
    end

    def show
      render json: flight_plan
    end

    def create
      flight_plan = flight_plan.new(flight_plan_params)
      if flight_plan.save
        render json: flight_plan
      else
        render_model_error(flight_plan)
      end
    end

    private

    def fetch_flight_plan
      @flight_plan = FlightPlan.find(params[:id])
    end

    def flight_plan_params
      # Getting around the single require argument issue
      [:origin, :destination, :speed, :interval].each do |p|
        params.require(p)
      end
      params.allow(:departure_time)
    end
  end
end
