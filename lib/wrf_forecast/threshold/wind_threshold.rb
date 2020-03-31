#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-19 13:59:43
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-31 16:31:25

module WrfForecast

  module Threshold

    # This class determines the significant wind thresholds for a forecast day.
    # That means that this class can only work correctly if the data represents a time
    # span of up to 24 hours.
    # The indicators and thresholds are bases on the climate indicators of the german
    # (weatherservice)[https://www.dwd.de/DE/wetter/warnungen_aktuell/kriterien/warnkriterien.html]:
    # * squall day: the wind speed exceeds 14 m/s or 7 bft
    # * storm squall day: the wind speed exceeds 24 m/s or 8 bft
    # * storm day: the wind speed exceeds 28 m/s or 10 bft
    # * hurricane day: the wind speed exceeds 32 m/s or 11 bft
    class WindThreshold < BaseThreshold

      private

      # initialization of the required indicators
      def initialize_indicators
        @indicators[:squall_day] = false
        @indicators[:storm_squall_day] = false
        @indicators[:storm_day] = false
        @indicators[:hurricane_day] = false
        nil
      end

      # method to determine the indicators based on the input data
      # @param [Array] data_values the input values
      def determine_indicators(data_values)
        data_values.each { |value|
          @indicators[:squall_day] = true if (value > 14.0)
          @indicators[:storm_squall_day] = true if (value > 24.0)
          @indicators[:storm_day] = true if (value > 28.0)
          @indicators[:hurricane_day] = true if (value >= 32.0)
        }
        nil
      end

    end

  end

end
