#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-19 13:59:43
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-01-24 08:56:46

module WrfForecast

  module Threshold

    # This class determines the significant wind thresholds for a forecast day.
    # That means that this class can only work correctly if the data represents a time
    # span of up to 24 hours.
    # The indicators and thresholds are based on the climate indicators of the german
    # (weatherservice)[https://www.dwd.de/DE/wetter/warnungen_aktuell/kriterien/warnkriterien.html]
    # and an additional catecory for medium strong wind:
    # * windy day: the wind speed exceeds 9 m/s or 5 bft
    # * squall day: the wind speed exceeds 14 m/s or 7 bft
    # * storm squall day: the wind speed exceeds 24 m/s or 9 bft
    # * storm day: the wind speed exceeds 28 m/s or 10 bft
    # * hurricane day: the wind speed exceeds 33 m/s or 11 bft
    class WindThreshold < BaseThreshold

      private

      # initialization of the required indicators
      def initialize_indicators
        add_indicator(:windy_day, false, "windy day (wind speed exceeds 9 m/s, 33 km/h, 5 bft)")
        add_indicator(:squall_day, false, "squall day (wind speed exceeds 14 m/s, 51 km/h, 7 bft)")
        add_indicator(:storm_squall_day, false, 
                      "storm squall day (wind speed exceeds 24 m/s, 87 km/h, 9 bft)")
        add_indicator(:storm_day, false, "storm day (wind speed exceeds 28 m/s, 101 km/h, 10 bft)")
        add_indicator(:hurricane_day, false, "hurricane day (wind speed exceeds 33 m/s, 119 km/h, 11 bft)")
        nil
      end

      # method to determine the indicators based on the input data
      # @param [Array] data_values the input values
      def determine_indicators(data_values)
        data_values.each { |value|
          change_indicator(:windy_day, true, value > 9.0)
          change_indicator(:squall_day, true, value > 14.0)
          change_indicator(:storm_squall_day, true, value > 24.0)
          change_indicator(:storm_day, true, value > 28.0)
          change_indicator(:hurricane_day, true, value > 33.0)
        }
        nil
      end

    end

  end

end
