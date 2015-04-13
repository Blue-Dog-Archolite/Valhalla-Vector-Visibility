class FlightPath
  attr_accessor :speed, :frequency, :departure

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

  def distance
    @distance ||= origin.distance_to(destination)
  end

  def heading
    @heading ||= origin.heading_to(destination)
  end

  def intervals
    # Round off that last one
    (travel_time / frequency).to_i
  end

  def travel_time
    (distance / speed)
  end

  def points
    @forcast_locations ||= calculate_points
  end

  def forecast
    return @forecast unless @forecast.blank?

    @forecast = points.collect do |time, location|
        ForecastForPointInTimeAndSpace.predict(location, time)
    end

    @forecast
  end

  private

  def calculate_points
    # Origin location and time
    # This saves an extra call that would happen for origin.endpoint(heading, 0)
    @forcast_locations = { departure => origin }

    # Points between
    (1..intervals).each do |current_interval|
      current_time_location = (current_interval * frequency)
      @forcast_locations[time_at_interval(current_time_location)] = origin.endpoint(heading, (current_time_location * speed).to_i)
    end

    # Destination location and time
    # This saves an extra call
    @forcast_locations[time_at_interval(travel_time)] = destination

    @forcast_locations
  end

  def lat_long_or_airport_code(location)
    # Lookup airport, if airport
    location =  WorldAirports.iata(location).location if location.length == 3

    # return geocoded city
    Geokit::Geocoders::GoogleGeocoder.geocode(location)
  end

  def time_at_interval(current_time_interval)
    Time.at(departure.to_i + current_time_interval.hours)
  end
end
