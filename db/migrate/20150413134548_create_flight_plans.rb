class CreateFlightPlans < ActiveRecord::Migration
  def change
    create_table :flight_plans do |t|
      t.string :origin
      t.string :destination
      t.integer :speed
      t.integer :interval

      t.timestamps
    end
  end
end
