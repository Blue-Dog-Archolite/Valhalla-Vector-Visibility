require 'spec_helper'

describe ForecastForPointInTimeAndSpace, :vcr do
  let(:subject)     { ForecastForPointInTimeAndSpace }
  let(:flight_path) { FactoryGirl.build(:ord_to_boi) }

  it '#predict' do
    flight_path.each do |time, location|
      ff = subject.predict(location, time.to_i)

      expect(ff[:time]).to eq(time.strftime('%m-%d-%Y %H:%M'))
      [
        :latitude, :longitude, :time,
        :summary, :precipIntensity, :precipProbability,
        :temperature, :apparentTemperature, :dewPoint,
        :humidity, :windSpeed, :windBearing
      ].each do |k|
        expect(ff.key?(k)).to be(true)
      end
    end
  end

  it 'only calls to ForecastIO once per set of data' do
    point = flight_path.first
    key = Rails.env + '-41.8781136,-87.6297982-1388559600'
    value = Hashie::Mash.new('currently' => { 'time' => DateTime.new.to_time.to_i})
    REDIS.del(key)
    expect(ForecastIO).to receive(:forecast).once.and_return(value)
    subject.predict(point[1], point[0])
    subject.predict(point[1], point[0])
  end

  it 'returns the correct time stamp for time requested' do
    point = flight_path.first
    subject.predict(point[1], point[0])
  end

end
