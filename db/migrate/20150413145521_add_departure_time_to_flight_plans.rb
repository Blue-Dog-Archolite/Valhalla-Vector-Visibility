class AddDepartureTimeToFlightPlans < ActiveRecord::Migration
  def change
    add_column :flight_plans, :departure_time, :datetime
  end
end
