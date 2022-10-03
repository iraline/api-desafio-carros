require 'csv'

class CsvData

    INDEX_PROFILE_VIN = 0 
    INDEX_PROFILE_YEAR = 1 
    INDEX_PROFILE_NAME = 2

    INDEX_DTC_TIMESTAMP = 0
    INDEX_DTC_VIN = 1
    INDEX_DTC_FUEL_CONSUME = 2

    INDEX_IGNITE_LOCATION_VIN = 0 
    INDEX_IGNITE_LOCATION_LATITUDE = 4
    INDEX_IGNITE_LOCATION_LONGITUDE = 5
    INDEX_IGNITE_LOCATION_TIMESTAMP = 8

    INDEX_GCD_VIN  = 0
    INDEX_GCD_TIMESTAMP = 2
    INDEX_GCD_FUEL = 4

    def initialize(profile, ignite_location, gcd, dtc, path)   
        profile = path + profile
        ignite_location = path + ignite_location
        gcd = path + gcd
        dtc = path + dtc

        @profiles = CSV.parse(File.read(profile), headers: true).to_a
        @ignite_locations = CSV.parse(File.read(ignite_location), headers: true).to_a
        @gcd_informations = CSV.parse(File.read(gcd), headers: true).to_a
        @dtc_informations = CSV.parse(File.read(dtc), headers: true).to_a
    end 

    def avg_consume_by_car_model_or_period(model,year,year_period = nil)
        
        profile_cars = vins_model(model,year).pluck(INDEX_PROFILE_VIN)
        dtc_informations_cp = @dtc_informations.dup 
        
        #Da pra  criar um metodo disso e utilizar no avg_consume_cars_model_city
        if year_period 
            dtc_informations_cp.keep_if { |event|
                (profile_cars.any?(event[INDEX_DTC_VIN])) and
                (event[INDEX_DTC_TIMESTAMP][0..3] == year_period)
            }    
        else
            dtc_informations_cp.keep_if { |event|
                profile_cars.any?(event[INDEX_DTC_VIN])
            }
        end

        sum_consume_events = dtc_informations_cp.pluck(INDEX_DTC_FUEL_CONSUME).map(&:to_f).reduce(:+)

        if sum_consume_events
            (sum_consume_events / dtc_informations_cp.count).round(2)
        else
            "There is no event in the specified year"
        end
    end

    def avg_consume_cars_model_state(model,year,state,year_period)
        profile_cars = vins_model(model,year).pluck(INDEX_PROFILE_VIN)
        ignite_locations_cp = @ignite_locations.dup 
        dtc_informations_cp = @dtc_informations.dup 

        ignite_locations_cp.keep_if { |event|
            (profile_cars.any?(event[INDEX_IGNITE_LOCATION_VIN])) and
           # (local(event[INDEX_IGNITE_LOCATION_LATITUDE],event[INDEX_IGNITE_LOCATION_LONGITUDE]) == state) and
            (event[INDEX_IGNITE_LOCATION_TIMESTAMP][0..3] == year_period)
        }

        ignite_locations_cp.keep_if { |event|
            (local(event[INDEX_IGNITE_LOCATION_LATITUDE],event[INDEX_IGNITE_LOCATION_LONGITUDE]) == state)
        }
  
        elegible_vin_cars = ignite_locations_cp.pluck(INDEX_IGNITE_LOCATION_VIN).uniq

        dtc_informations_cp.keep_if { |event|
                (elegible_vin_cars.any?(event[INDEX_DTC_VIN])) and
                (event[INDEX_DTC_TIMESTAMP][0..3] == year_period)
        }  

        sum_consume_events = dtc_informations_cp.pluck(INDEX_DTC_FUEL_CONSUME).map(&:to_f).reduce(:+)

        if sum_consume_events
            (sum_consume_events / dtc_informations_cp.count).round(2)
        else
            "There is no event in the specified year"
        end
    end

    def get_history_car_fueling(vin)
        gcd_informations_cp = @gcd_informations.dup

        gcd_informations_cp.keep_if  { |event|
            event[INDEX_GCD_VIN] == vin
        }

        old_fuel = 0
        fueling = []
        list_fueling = []

        gcd_informations_cp.each { |event|
            if event[INDEX_GCD_FUEL].to_i > old_fuel
                fueling.push(event[INDEX_GCD_TIMESTAMP])
                fueling.push((event[INDEX_GCD_FUEL].to_i - old_fuel))
                list_fueling.push(fueling)
                fueling = []
            end
            old_fuel = event[INDEX_GCD_FUEL].to_i
        }
        list_fueling
    end

    private

    def vins_model(model,year)
        profiles = @profiles.to_a

        profiles.select { |profile|
            profile[INDEX_PROFILE_NAME] == model and profile[INDEX_PROFILE_YEAR] == year
        }
    end

    def local(latitude, longitude)
        if (latitude) and (longitude)
            search_param = latitude + "," + longitude
            complete_location = Geocoder.search(search_param)
            complete_location.first.state
        end
    end

end
