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
        add_indicator(:ice_day, true, I18n.t("threshold.temperature.ice_day"))
        add_indicator(:frost_day, false, I18n.t("threshold.temperature.frost_day"))
        add_indicator(:summer_day, false, I18n.t("threshold.temperature.summer_day"))
        add_indicator(:hot_day, false, I18n.t("threshold.temperature.hot_day"))
        add_indicator(:tropical_night, true, I18n.t("threshold.temperature.tropical_night"))
        nil
      end

      # method to determine the indicators based on the input data
      # @param [Array] data_values the input values
      def determine_indicators(data_values)
        data_values.each { |value|
          change_indicator(:ice_day, false, value > 273.15)
          change_indicator(:frost_day, true, value < 273.15)
          change_indicator(:summer_day, true, value > 298.15)
          change_indicator(:hot_day, true, value > 303.15)
          change_indicator(:tropical_night, false, value < 293.15)
        }
        nil
      end

    end

  end

end
