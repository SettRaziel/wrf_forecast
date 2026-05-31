module WrfForecast

  module Threshold

    # This class determines the thresholds of glaze for a forecast day.
    # That means that this class can only work correctly if the data represents a time
    # span of up to 24 hours.
    # Due to precipitation of high humidity the conditions for glaze creation on the surface are given
    # * glaze day: the conditions for glaze are given
    class GlazeThreshold < BaseThreshold

      private

      # initialization of the required indicators
      def initialize_indicators
        add_indicator(:glaze_day, false, I18n.t("threshold.glaze.glaze_day"))
        nil
      end

      # method to determine the indicators based on the input data
      # @param [Array] data_values the input values
      def determine_indicators(data_values)
        data_values.each { |value|
          # ground is not frozen, but precipitation is likely snow
          indicator = value[:air_temperature] < 273.15 && value[:soil_temperature] > 273.15)
          change_indicator(:glaze_day, true, value[:precipitation] > 0 && indicator) 
          # ground is frozen, but precipitation is likely liquid
          indicator = value[:air_temperature] > 273.15 && value[:soil_temperature] < 273.15)
          change_indicator(:glaze_day, true, value[:precipitation] > 0 && indicator)
        }
        nil
      end

    end

  end

end
