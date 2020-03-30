#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-20 12:14:58
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-24 19:19:51

module Threshold

  # This class determines the significant rain thresholds for a forecast day.
  # That means that this class can only work correctly if the data represents a time
  # span of up to 24 hours.
  # The indicators and thresholds are bases on the climate indicators of the german
  # (weatherservice)[https://www.dwd.de/DE/wetter/warnungen_aktuell/kriterien/warnkriterien.html?nn=508722]:
  # * strong rain: the hourly rain sum exceeds 15 mm per hour
  # * heavy rain: the hourly rain sum exceeds 25 mm per hour
  # * extreme rain: the hourly rain sum exceeds 40 mm per hour
  # * continous rain: the rain sum over 24 hours exceeds a total of 30 mm
  class RainThreshold < BaseThreshold

    private

    # initialization of the required indicators
    def initialize_indicators
      @indicators[:strong_rain] = false
      @indicators[:heavy_rain] = false
      @indicators[:extreme_rain] = false
      @indicators[:continous_rain] = false
      nil
    end

    # method to determine the indicators based on the input data
    # @param [Array] data_values the input values
    def determine_indicators(data_values)
      sum = 0
      data_values.each { |value|
        @indicators[:strong_rain] = true if (value > 15.0)
        @indicators[:heavy_rain] = true if (value > 25.0)
        @indicators[:extreme_rain] = true  if (value > 40.0)
        sum += value
      }

      if (sum > 30.0 && !@indicators[:strong_rain])
        @indicators[:continous_rain] = true
      end
      nil
    end

    # method to check if the data sample offers enough data for the indicators
    # if we dont have 24 values we do not have hourly rain for the day
    # @raise [ArgumentError] if the data values are not sufficient
    def check_data_values(data_values)
      if (data_values.size != 24)
        raise ArgumentError, "Error: Not enough hourly data available."
      end
    end

  end

end
