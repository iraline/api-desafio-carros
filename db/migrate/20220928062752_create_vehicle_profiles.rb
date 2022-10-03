class CreateVehicleProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicle_profiles do |t|
      t.string :vin, null: false, index: { unique: true } 
      t.integer :year, null: false
      t.string :model, null: false
      t.string :brand, null: false
      
      t.timestamps
    end
  end
end
