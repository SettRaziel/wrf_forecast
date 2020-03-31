#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-19 08:04:09
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-31 16:30:32

module WrfForecast

  module Threshold

    # This class determines the significant temperature thresholds for a forecast day.
    # That means that this class can only work correctly if the data represents a time
    # span of up to 24 hours.
    # The indicators and thresholds are bases on the climate indicators of the german
    # (weatherservice)[https://www.dwd.de/DE/service/lexikon/lexikon_node.html]:
    # * ice day: the temperature of the day did not exceed 0.0 degrees celsius
    # * frost day: the temperature was below 0.0 degress celsius at least once
    # * summer day: the temperature did exceed 25.0 degress celsius at least once
    # * hot day: the temperature did exceed 30.0 degress celsius at least once
    # * tropical night: the temperature of the day did not fall below 20.0 degrees celsius
    class TemperatureThreshold < BaseThreshold

      private

      # initialization of the required indicators
      def initialize_indicators
        @indicators[:ice_day] = true
        @indicators[:frost_day] = false
        @indicators[:summer_day] = false
        @indicators[:hot_day] = false
        @indicators[:tropical_night] = true
        nil
      end

      # method to determine the indicators based on the input data
      # @param [Array] data_values the input values
      def determine_indicators(data_values)
        data_values.each { |value|
          @indicators[:ice_day] = false if (value > 273.15)
          @indicators[:frost_day] = true if (value < 273.15)
          @indicators[:summer_day] = true if (value >= 298.15)
          @indicators[:hot_day] = true if (value >= 303.15)
          @indicators[:tropical_night] = false if (value < 293.15) 
        }
        nil
      end

    end

  end

end
