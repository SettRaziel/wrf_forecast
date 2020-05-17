#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-22 11:32:06
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-05-14 16:59:18

module WrfForecast

  module Text

    # This class generates the forecast text for the temperature
    # data of the forecast
    # warnings: the hot day contains the summer day and can have a tropical night or frost day
    # but exclude the ice day
    # the ice day contains the frost day, both exclude tropical night
    class TemperatureText < MeasurandText

      private

      # method to generate the forecast text for the temperature
      def generate_forecast_text
        @text = "Today will be a "
        @text.concat(create_warmth_text).concat(".")
        @text.concat(create_temperature_text)
        nil
      end

      # method to generate the warning text for the measurand
      def generate_warning_text
        if (@thresholds[:frost_day].is_active && !@thresholds[:ice_day].is_active)
          @warnings.concat"\n" if (!@warnings.empty?)
          @warnings.concat(@thresholds[:frost_day].warning_text)
        end  
        @warnings
      end

      # method to generate the text about the day
      def create_warmth_text
        warmth = "normal"
        warmth = "cold" if (@thresholds[:frost_day].is_active)
        warmth = "very frosty" if (is_threshold_active?(:ice_day))
        warmth = "summer" if (is_threshold_active?(:summer_day))
        warmth = "hot" if (is_threshold_active?(:hot_day))

        warmth.concat(" day")
        if (@thresholds[:tropical_night].is_active)
          warmth.concat(" with a tropical night")
          @warnings.concat("\n") if (!@warnings.empty?)
          @warnings.concat(@thresholds[:tropical_night].warning_text)
        end
        return warmth
      end

      # method to generate the text with temperature values
      def create_temperature_text
        text = " The maximum temperature will reach up to "
        text.concat((@extreme_values.maximum - 273.15).ceil.to_s)
        text.concat(" degrees celsius. The minimum temperature will be ")
        text.concat((@extreme_values.minimum - 273.15).floor.to_s)
        text.concat(" degrees celsius.")
        return text
      end
      
    end

  end

end
