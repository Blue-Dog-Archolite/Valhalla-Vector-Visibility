class FlightPlan
  # Build this after it works
  def initialize(origin, destination, speed, frequency, departure = Time.now)
    @raw_origin = origin
    @raw_destination = destination
    @speed = speed
    @frequency = frequency
    @departure = departure
  end

  def origin
    @origin ||= lat_long_or_airport_code(@raw_origin)
  end

  def destination
    @destination ||= lat_long_or_airport_code(@raw_destination)
  end
end
