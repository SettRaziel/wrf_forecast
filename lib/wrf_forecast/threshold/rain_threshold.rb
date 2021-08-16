module WrfForecast

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
        add_indicator(:strong_rain, false, I18n.t("threshold.rain.strong_rain"))
        add_indicator(:heavy_rain, false, I18n.t("threshold.rain.heavy_rain"))
        add_indicator(:extreme_rain, false, I18n.t("threshold.rain.extreme_rain"))
        add_indicator(:continous_rain, false, I18n.t("threshold.rain.continous_rain"))
        nil
      end

      # method to determine the indicators based on the input data
      # @param [Array] data_values the input values
      def determine_indicators(data_values)
        sum = 0
        rain_hours = 0
        data_values.each { |value|
          change_indicator(:strong_rain, true, value > 15.0)
          change_indicator(:heavy_rain, true, value > 25.0)
          change_indicator(:extreme_rain, true, value > 40.0)
          rain_hours += 1 if (value > 1.5) # hourly rain > 1.5 mm required for continous rain check
          sum += value
        }

        change_indicator(:continous_rain, true, (sum > 30.0 && rain_hours > 6))
        nil
      end

      # method to check if the data sample offers enough data for the indicators
      # if we dont have 24 values we do not have hourly rain for the day
      # @raise [ArgumentError] if the data values are not sufficient
      def check_data_values(data_values)
        if (data_values.size < 24)
          raise ArgumentError, "Error: Not enough hourly data available for a forecast day."          
        end
      end

    end

  end

end
