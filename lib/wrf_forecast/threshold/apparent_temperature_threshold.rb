module WrfForecast

  module Threshold

    # This class determines the significant temperature thresholds of the apparent temperature
    # for a forecast day.
    # That means that this class can only work correctly if the data represents a time
    # span of up to 24 hours.
    # The indicators and thresholds are based on the climate indicators of the german
    # (weatherservice)[https://www.dwd.de/DE/wetter/warnungen_aktuell/kriterien/warnkriterien.html]:
    # * strong heat day: the apparent temperature of the day exceeds 32.0 degrees celsius
    # * extreme heat day: the apparent temperature of the day exceeds 38.0 degrees celsius
    class ApparentTemperatureThreshold < BaseThreshold

      private

      # initialization of the required indicators
      def initialize_indicators
        add_indicator(:strong_heat_day, false, I18n.t("threshold.apparent_temperature.strong_heat_day"))
        add_indicator(:extreme_heat_day, false, I18n.t("threshold.apparent_temperature.extreme_heat_day"))
        nil
      end

      # method to determine the indicators based on the input data
      # @param [Array] data_values the input values
      def determine_indicators(data_values)
        data_values.each { |value|
          change_indicator(:ice_day, true, value > 32.0)
          change_indicator(:frost_day, true, value > 38.0)
        }
        nil
      end

    end

  end

end
