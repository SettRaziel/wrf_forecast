module WrfForecast

  module Threshold

    # This class determines the significant pressure thresholds for a forecast day.
    # That means that this class can only work correctly if the data represents a time
    # span of up to 24 hours.
    # The indicators and thresholds are based on the climate indicators of the german
    # (weatherservice)[https://www.dwd.de/DE/wetter/warnungen_aktuell/kriterien/warnkriterien.html]:
    # * low pressure: the pressure is below 1005 hPa during the day
    # * very low pressure: the pressure is below 990 hPa during the day
    # * high pressure: the pressure is above 1020 hPa during the day
    # * very high pressure: the pressure is below 1035 hPa during the day
    class PressureThreshold < BaseThreshold

      private

      # initialization of the required indicators
      def initialize_indicators
        add_indicator(:low_pressure, false, I18n.t("threshold.pressure.low_pressure"))
        add_indicator(:very_low_pressure, false, I18n.t("threshold.pressure.very_low_pressure"))
        add_indicator(:high_pressure, false, I18n.t("threshold.pressure.low_pressure"))
        add_indicator(:very_high_pressure, false, I18n.t("threshold.pressure.very_high_pressure"))
        nil
      end

      # method to determine the indicators based on the input data
      # @param [Array] data_values the input values
      def determine_indicators(data_values)
        data_values.each { |value|
          change_indicator(:low_pressure, true, value < 100500)
          change_indicator(:very_low_pressure, true, value < 99000)
          change_indicator(:high_pressure, true, value > 102000)
          change_indicator(:very_high_pressure, true, value > 103500)
        }
        nil
      end

    end

  end

end
