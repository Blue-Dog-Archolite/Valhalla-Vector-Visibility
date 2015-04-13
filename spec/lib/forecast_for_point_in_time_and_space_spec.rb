require 'spec_helper'

describe ForecastForPointInTimeAndSpace, :vcr do
  let(:subject)     { ForecastForPointInTimeAndSpace }
  let(:flight_path) { FactoryGirl.build(:ord_to_boi) }

  it '#predict' do
    flight_path.each do |time, location|
      binding.pry
      ff = subject.predict(location, time.to_i)
      expect(ff.time).to eq(time.to_i)
      [
        'time', 'summary', 'icon', 'precipIntensity',
        'precipProbability', 'temperature', 'apparentTemperature',
        'dewPoint', 'humidity', 'windSpeed', 'windBearing',
        'visibility'
      ].each do |k|
        expect(ff.currently.key?(k.to_sym)).to be(true)
      end
    end
  end

  it 'only calls to ForecastIO once per set of data' do
    point = flight_path.first
    key = Rails.env + '-41.8781136,-87.6297982-1388559600'
    value = Hashie::Mash.new('currently' => { 'key' => 'value' })
    REDIS.del(key)
    expect(ForecastIO).to receive(:forecast).once.and_return(value)
    subject.predict(point[1], point[0])
    subject.predict(point[1], point[0])
  end
end
