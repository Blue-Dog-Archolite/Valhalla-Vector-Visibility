module ForecastForPointInTimeAndSpace
  def self.predict(geo_point, time)
    time = time.is_a?(DateTime) ? time.to_time : time
    # cache and check
    key = "#{Rails.env}-#{geo_point.ll}-#{time.to_i}"

    if REDIS.get(key)
      JSON.parse(REDIS.get(key))
    else
      forecast = ForecastIO.forecast(geo_point.ll, time.to_i)
      simplified_forecast = self.simplify_forecast(forecast)
      REDIS.set(key, simplified_forecast.to_json)

      simplified_forecast
    end
  end


  def self.simplify_forecast(forecast)
    {
      latitude:             forecast.latitude,
      longitude:            forecast.longitude,
      time:                 self.formatted_time(forecast),
      summary:              forecast.currently.summary,
      precipIntensity:      forecast.currently.precipIntensity,
      precipProbability:    forecast.currently.precipProbability,
      temperature:          forecast.currently.temperature,
      apparentTemperature:  forecast.currently.apparentTemperature,
      dewPoint:             forecast.currently.dewPoint,
      humidity:             forecast.currently.humidity,
      windSpeed:            forecast.currently.windSpeed,
      windBearing:          forecast.currently.windBearing
    }
  end

  def self.formatted_time(forecast)
    Time.at(forecast.currently.time).strftime('%m-%d-%Y %H:%M')
  end
end
