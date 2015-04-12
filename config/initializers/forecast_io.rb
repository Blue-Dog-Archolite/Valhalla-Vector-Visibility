ForecastIO.configure do |configuration|
  configuration.api_key = ENV['FORECAST_IO_API_KEY']
end

#forecast = ForecastIO.forecast(37.8267, -122.423, time: Time.new(2013, 3, 11).to_i)
