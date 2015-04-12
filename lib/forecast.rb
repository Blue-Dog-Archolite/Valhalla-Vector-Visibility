module Forecast
  def self.forcast_for(geo_point, time)
    # cache and check
    ForecastIO.forecast(geo_point, time)
  end
end
