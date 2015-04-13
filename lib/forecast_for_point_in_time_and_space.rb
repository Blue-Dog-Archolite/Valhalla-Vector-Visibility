module ForecastForPointInTimeAndSpace
  def self.predict(geo_point, time)
    # cache and check
    key = "#{Rails.env}-#{geo_point.ll}-#{time.to_i}"

    if REDIS.get(key)
      JSON.parse(REDIS.get(key))
    else
      forecast = ForecastIO.forecast(geo_point.ll, time.to_i)
      REDIS.set(key, forecast.currently.to_json)

      forecast.currently
    end
  end
end
