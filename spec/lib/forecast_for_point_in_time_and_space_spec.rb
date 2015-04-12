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
end

