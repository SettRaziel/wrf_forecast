#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-23 16:27:56
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-05-13 18:22:46

module WrfForecast

  module Text

    # This class generates the forecast text for the wind speed
    # and direction of the forecast
    class WindText < MeasurandText

      # initialization
      # @param [ExtremeValues] extreme_values the wind extreme values
      # @param [Symbol] prevalent_direction the prevalent wind direction
      # @param [WindThreshold] thresholds the wind threshold
      def initialize(extreme_values, prevalent_direction, thresholds)
        @prevalent_direction = prevalent_direction
        initialize_directions
        super(extreme_values, thresholds)
      end

      private

      # @return [Symbol] the prevalent wind direction
      attr_reader :prevalent_direction
      # @return [Hash] the mapping of direction and direction name
      attr_reader :directions

      # method to initialize the mapping from direction to direction text
      def initialize_directions
        @directions = Hash.new()
        @directions[:N]  = "north"
        @directions[:S]  = "south"
        @directions[:W]  = "west"
        @directions[:E]  = "east"
        @directions[:NW] = "northwest"
        @directions[:NE] = "northeast"
        @directions[:SW] = "southwest"
        @directions[:SE] = "southeast"
        nil
      end

      # method to generate the forecast text for the wind
      def generate_forecast_text
        @text = "The wind will be "
        @text.concat(create_strength_text)
        @text.concat(create_wind_text)
        nil
      end

      # method to generate the warning text for the measurand
      # @return [String] the warning text
      def generate_warning_text
        @warnings
      end

      # method to generate the text about the day
      def create_strength_text
        wind_strength = "normal"
        wind_strength = "squall" if (is_threshold_active?(:squall_day))
        wind_strength = "stormy" if (is_threshold_active?(:storm_squall_day))
        wind_strength = "very stromy" if (is_threshold_active?(:storm_day))
        wind_strength = "extremly stromy" if (is_threshold_active?(:hurricane_day))
        return wind_strength
      end

      # method to generate the text with wind values
      def create_wind_text
        text = " and will reach up to "
        text.concat((@extreme_values.maximum * 3.6).ceil.to_s)
        text.concat(" km/h from ")
        text.concat(create_prevalent_direction_text)
        text.concat(". The mean wind will be ")
        mean = (@extreme_values.maximum + @extreme_values.minimum) / 2.0
        text.concat((mean * 3.6).ceil.to_s)
        text.concat(" km/h.")
        return text
      end

      # method to create the text for the prevalent wind direction
      def create_prevalent_direction_text
        if (@prevalent_direction == nil)
          return "circulatory directions"
        end
        return @directions[@prevalent_direction]
      end

    end

  end

end
