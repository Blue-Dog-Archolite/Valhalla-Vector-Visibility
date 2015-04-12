module ForecastForPointInTimeAndSpace
  def self.forecast_for(geo_point, time)
    # cache and check
    key = "#{geo_point.ll}-#{time.to_i}"

    if REDIS.get(key)
      JSON.parse(REDIS.get(key))
    else
      forecast = ForecastIO.forecast(geo_point.ll, time.to_i)
      REDIS.set(key, forecast.to_json)
      forecast
    end
  end
end
