require 'spec_helper'

describe FlightPath do
  before do
    @origin = FactoryGirl.build(:ord_airport)
    @destination = FactoryGirl.build(:boi_airport)
    # set static time to allow for VCR catch as well as back forecasting
    @starting_time = Time.new('2014/03/21')
  end

  describe 'gets all current conditions for the time and location', :vcr do
    before do
      @flight_path = FlightPath.new(@origin[:code], @destination[:code], 100, 1, @starting_time)
    end

    it 'pulls the current values from forecast' do
      forecast = @flight_path.forecast
      expected_forecast = FactoryGirl.build(:ord_to_boi_forecast)
      expect(forecast).to eq(expected_forecast)
    end

  end

  # TODO move this all to flight plan
  describe 'airport codes', :vcr do
    before do
      @flight_path = FlightPath.new(@origin[:code], @destination[:code], 100, 1, @starting_time)
    end

    it 'looks up origin with airport code' do
      expect(@flight_path.origin.city).to eq('Chicago')
    end

    it 'looks up destination with airport code' do
      expect(@flight_path.destination.city).to eq('Boise')
    end

    it 'calculates the distance correctly' do
      expect(@flight_path.distance).to eq(1449.7495636431977)
    end

    it 'calculates the intervals correctly' do
      expect(@flight_path.intervals).to eq(14)
    end

    it 'calculates the forcast points correctly' do
      points = @flight_path.points
      point_times = [1388559600, 1388563200, 1388566800,
                     1388570400, 1388574000, 1388577600,
                     1388581200, 1388584800, 1388588400,
                     1388592000, 1388595600, 1388599200,
                     1388602800, 1388606400, 1388610000,
                     1388611790]

      expect(points.keys.count).to eq(16)

      # Using to_i to get around issues with Matchers and Times
      expect(points.keys.map(&:to_i)).to match_array(point_times)
    end

    it 'hands off responsibility to ForecastFlightPlan' do
      expect(ForecastForPointInTimeAndSpace).to receive(:predict).and_return({}).exactly(16).times
      @flight_path.forecast
    end
  end

  describe 'lat, long', :vcr do
    before do
      @flight_path = FlightPath.new(@origin[:ll], @destination[:ll], 100, 1, @starting_time)
    end

    it 'looks up origin with airport code' do
      expect(@flight_path.origin.city).to eq('Chicago')
    end

    it 'looks up destination with airport code' do
      expect(@flight_path.destination.city).to eq('Boise')
    end

    it 'calculates the distance correctly' do
      # Difference due to exact locations
      expect(@flight_path.distance).to eq(1435.0494809532943)
    end

    it 'calculates the intervals correctly' do
      expect(@flight_path.intervals).to eq(14)
    end

    it 'calculates the forcast points correctly' do
      # Difference due to exact locations
      points = @flight_path.points
      point_times = [1388559600, 1388563200, 1388566800,
                     1388570400, 1388574000, 1388577600,
                     1388581200, 1388584800, 1388588400,
                     1388592000, 1388595600, 1388599200,
                     1388602800, 1388606400, 1388610000,
                     1388611261]

      expect(points.keys.count).to eq(16)

      # Using to_i to get around issues with Matchers and Times
      expect(points.keys.map(&:to_i)).to match_array(point_times)
    end
  end
end
