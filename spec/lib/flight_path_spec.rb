require 'spec_helper'

describe FlightPath do
  before do
    @origin = FactoryGirl.build(:ord_airport)
    @destination = FactoryGirl.build(:boi_airport)
    # set static time to allow for VCR catch as well as back forecasting
    @starting_time = DateTime.new(2014,03,21)
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

    it 'has interval correclty calculated' do
      expect(@flight_path.intervals).to be(14)

      expect(@flight_path).to receive(:frequency).and_return(2)
      expect(@flight_path.intervals).to be(7)
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
      point_times = [
        1395360000, 1395363600, 1395367200, 1395370800,
        1395374400, 1395378000, 1395381600, 1395385200,
        1395388800, 1395392400, 1395396000, 1395399600,
        1395403200, 1395406800, 1395410400, 1395412190
      ]

      expect(points.keys.count).to eq(16)

      # Using to_i to get around issues with Matchers and Times
      expect(points.keys.map(&:to_i)).to match_array(point_times)
    end

    it 'hands off responsibility to ForecastFlightPlan' do
      expect(ForecastForPointInTimeAndSpace).to receive(:predict).and_return({}).exactly(16).times
      @flight_path.forecast
    end
  end

  describe 'lat, long with interval 3', :vcr do
    before do
      @flight_path = FlightPath.new(@origin[:ll], @destination[:ll], 100, 3, @starting_time)
    end

    it 'calculates the distance correctly' do
      # Difference due to exact locations
      expect(@flight_path.distance).to eq(1435.0494809532943)
    end

    it 'calculates the intervals correctly' do
      expected_intervals =  (@flight_path.distance / (100 * 3)).to_i
      expect(@flight_path.intervals).to eq(expected_intervals)
    end

    it 'calculates the forcast points correctly' do
      # Difference due to exact locations
      points = @flight_path.points

      point_times = [
        # Force time settings to verify correct plot points
        (@starting_time + 0.hours).to_i,
        (@starting_time + 3.hours).to_i,
        (@starting_time + 6.hours).to_i,
        (@starting_time + 9.hours).to_i,
        (@starting_time + 12.hours).to_i,
        # Arrival Time
        1395411661
      ]

      expect(@flight_path.travel_time.to_i).to eq(14)

      expect(points.keys.count).to eq(6)

      # Using to_i to get around issues with Matchers and Times
      expect(points.keys.map(&:to_i)).to match_array(point_times)
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
      point_times = [
        1395360000, 1395363600, 1395367200, 1395370800,
        1395374400, 1395378000, 1395381600, 1395385200,
        1395388800, 1395392400, 1395396000, 1395399600,
        1395403200, 1395406800, 1395410400, 1395411661
      ]

      expect(points.keys.count).to eq(16)

      # Using to_i to get around issues with Matchers and Times
      expect(points.keys.map(&:to_i)).to match_array(point_times)
    end
  end
end
