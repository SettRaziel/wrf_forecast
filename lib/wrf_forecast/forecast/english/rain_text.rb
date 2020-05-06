#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-24 15:49:26
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-05-06 18:58:00

module WrfForecast

  module Text

    # This class generates the forecast text for the rain data of the forecast
    class RainText < MeasurandText

      # initialization
      # @param [ExtremeValues] extreme_values the hourly rain extreme values
      # @param [Array] hourly_rain the hourly rain sums
      # @param [RainThreshold] thresholds the rain threshold
      def initialize(extreme_values, hourly_rain, thresholds)
        @hourly_rain = hourly_rain
        super(extreme_values, thresholds)
      end

      private

      # @return [Array] the hourly rain sums
      attr_reader :hourly_rain

      # method to generate the forecast text for the rain
      def generate_forecast_text
        if (!shall_it_rain?)
          @text = 'The forecast does not predict rain.'
        else
          @text = 'The forecast does predict '
          @text.concat(create_intensity_text)
          @text.concat(create_rain_text)
        end
        nil
      end

      # method to generate the text about the day
      def create_intensity_text
        intensity = 'normal'
        intensity = 'strong' if (@thresholds[:strong_rain])
        intensity = 'heavy' if (@thresholds[:heavy_rain])
        intensity = 'extreme' if (@thresholds[:extreme_rain])
        intensity = 'continous' if (@thresholds[:continous_rain])
        return intensity
      end

      # method to generate the text with rain values
      def create_rain_text
        text = ' rain with a maximum of '
        if (@thresholds[:continous_rain])
          text.concat(get_rain_sum.ceil.to_s)
          text.concat(' mm in 24 hours')
        else
          text.concat(@extreme_values.maximum.round(1).to_s)
          text.concat(' mm in 1 hour')
        end

        if (@extreme_values.minimum.round(5) == 0.0)
          text.concat(' and some dry periods ')
        else
          text.concat(' and no dry periods ')
        end
        text.concat('during the day.')
        return text
      end

      # method to check if it should rain in the forecast time
      def shall_it_rain?
        @hourly_rain.each { |value|
          return true if (value > 0.05)
        }
        return false
      end

      # method to get the total rain of the day
      def get_rain_sum
        sum = 0
        @hourly_rain.each { |value|
          sum += value
        }
        return sum
      end

    end

  end

end
