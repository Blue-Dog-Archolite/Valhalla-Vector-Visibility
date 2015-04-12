require 'spec_helper'

describe ForecastForPointInTimeAndSpace, :vcr do
  let(:subject)     { ForecastForPointInTimeAndSpace }
  let(:flight_path) { FactoryGirl.build(:ord_to_boi) }

  it '#forecast_for' do
    flight_path.each do |time, location|
      ff = subject.forecast_for(location, time.to_i)
      expect(ff.currently.time).to eq(time.to_i)
      expect(ff.keys).to eq(
        [
          "latitude", "longitude", "timezone", "offset",
          "currently", "hourly", "daily", "flags"
        ]
      )
    end
  end

  it 'only calls to ForecastIO once per set of data' do
    point = flight_path.first
    key = "41.8781136,-87.6297982-1388559600"
    REDIS.del(key)
    expect(ForecastIO).to receive(:forecast).once.and_return({"key" => "value"})
    subject.forecast_for(point[1], point[0])
    subject.forecast_for(point[1], point[0])
  end
end

