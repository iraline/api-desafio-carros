class VehicleProfile < ApplicationRecord
    has_many :gcds
    has_many :ignite_locations
end
