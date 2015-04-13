class FlightPlan < ActiveRecord::Base
  def forecast
    flight_path.forecast
  end

  private

  def flight_path
    @flight_path ||= FlightPath.new(origin, destination, speed, interval, departure_time)
  end
end
