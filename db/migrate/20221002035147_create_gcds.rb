class CreateGcds < ActiveRecord::Migration[7.0]
  def change
    create_table :gcds do |t|
      #t.belongs_to :vehicle_profile, foreign_key: true
      t.string :vin, null: false, index: { unique: true } 
      t.integer :fuel, null: false
      t.integer :odometer, null: false

      t.timestamps
    end
  end
end
