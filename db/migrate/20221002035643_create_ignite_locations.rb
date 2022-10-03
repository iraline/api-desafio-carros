class CreateIgniteLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :ignite_locations do |t|
      #t.belongs_to :vehicle_profile, foreign_key: true
      t.string :vin, null: false, index: { unique: true } 
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
  end
end
