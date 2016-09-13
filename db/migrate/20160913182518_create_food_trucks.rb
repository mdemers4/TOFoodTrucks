class CreateFoodTrucks < ActiveRecord::Migration[5.0]
  def change
    create_table :food_trucks do |t|
      t.string :truck_name
      t.string :time
      t.string :location
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
