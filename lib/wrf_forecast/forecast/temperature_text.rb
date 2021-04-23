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
        @text = I18n.t("forecast_text.temperature.text_start")
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
        warmth = I18n.t("forecast_text.temperature.warmth_normal")
        if (is_threshold_active?(:ice_day))
          warmth = I18n.t("forecast_text.temperature.warmth_very_frosty")
        elsif (@thresholds[:frost_day].is_active)
          warmth = I18n.t("forecast_text.temperature.warmth_cold")
        end

        if (is_threshold_active?(:hot_day))
          warmth = I18n.t("forecast_text.temperature.warmth_hot")
        elsif (is_threshold_active?(:summer_day))
          warmth = I18n.t("forecast_text.temperature.warmth_summer")
        end

        warmth.concat(I18n.t("forecast_text.temperature.text_day"))
        if (@thresholds[:tropical_night].is_active)
          warmth.concat(I18n.t("forecast_text.temperature.warmth_tropical"))
          @warnings.concat("\n") if (!@warnings.empty?)
          @warnings.concat(@thresholds[:tropical_night].warning_text)
        end
        return warmth
      end

      # method to generate the text with temperature values
      def create_temperature_text
        text = I18n.t("forecast_text.temperature.text_maximum")
        text.concat((@extreme_values.maximum - 273.15).ceil.to_s)
        text.concat(I18n.t("forecast_text.temperature.text_minimum"))
        text.concat((@extreme_values.minimum - 273.15).floor.to_s)
        text.concat(I18n.t("forecast_text.temperature.text_finish"))
        return text
      end
      
    end

  end

end
