class FuelConsume

    def initialize(profile, ignite_location, gcd, dtc)
        @profile = profile
        @ignite_location = ignite_location
        @gcd_information = gcd
        @dtc_information = dtc
    end 

    def by_model(model,year)
        #Consumo por modelo/ano
        #Input - modelo, ano
        #Output - KM/L
    end

    def by_state(model,year,state)
        #Consumo por região
        #Input - modelo, ano, cidade
        #Output - KM/L   
    end

    def gcd_information
       
    end

end