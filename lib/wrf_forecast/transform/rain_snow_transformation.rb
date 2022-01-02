module WrfForecast

  # This module transforms the rain amount to its corresponding snow amount for a given temperature and back
  # The thresholds are intervals, meaning:
  # * 270.15 <= t < 274.15: 10
  # * 266.15 <= t < 270.15: 15
  # * 263.15 <= t < 266.15: 20
  # * 260.15 <= t < 263.15: 30
  # * 255.15 <= t < 260.15: 40
  # * 244.15 <= t < 255.15: 50
  # *           t < 244.15: 100
  module RainSnowTransformation

    # @return [Hash] the hash storing the temperature treshold and ratio factor
    # the ration is valid from its threshold to the previous threshold
    attr_reader :thresholds

    # main entry point and initialization
    def self.initialize
      @thresholds = Hash.new()
      @thresholds[244.15] = 100
      @thresholds[255.15] = 50
      @thresholds[260.15] = 40
      @thresholds[263.15] = 30
      @thresholds[266.15] = 20
      @thresholds[270.15] = 15
      @thresholds[274.15] = 10
    end


    # method to determine the snow amount for the given rain amount
    # @param [Float] rain_amount the precipitation amount
    # @param [Temperature] temperature the given air temperature
    # @return [Float] the transformed value or nil if the temperature is greater than 274.15 Kelvin
    def self.rain_to_snow(rain_amount, temperature)
      initialize if (@thresholds.nil?)
      @thresholds.each_key { |key| 
        return rain_amount * @thresholds[key] if (temperature < key)
      }
      nil
    end

    # method to determine the rain amount for the given snow amount
    # @param [Float] snow_amount the precipitation amount
    # @param [Temperature] temperature the given air temperature
    # @return [Float] the transformed value or nil if the temperature is greater than 274.15 Kelvin
    def self.snow_to_rain(snow_amount, temperature)
      initialize if (@thresholds.nil?)
      @thresholds.each_key { |key| 
        return snow_amount / @thresholds[key] if (temperature < key)
      }
      nil
    end

  end

end
