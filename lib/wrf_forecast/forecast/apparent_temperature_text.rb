module WrfForecast

  module Text

    # This class generates the forecast text for the apparent temperature
    # data of the forecast
    class ApparentTemperatureText < MeasurandText

      private

      # method to generate the forecast text for the apparent temperature
      def generate_forecast_text
        @text = I18n.t("forecast_text.apparent_temperature.text_start")
        @text.concat(create_warmth_text)
        @text.concat(create_temperature_text)
        nil
      end

      # method to generate the warning text for the measurand
      def generate_warning_text 
        @warnings
      end

      # method to generate the text about the day
      # @return [String] the substring containing the temperature category
      def create_warmth_text
        warmth = I18n.t("forecast_text.apparent_temperature.feeling_normal")
        if (is_threshold_active?(:extreme_heat_day))
          warmth = I18n.t("forecast_text.apparent_temperature.feeling_extreme_heat")
        elsif (is_threshold_active?(:strong_heat_day))
          warmth = I18n.t("forecast_text.apparent_temperature.feeling_strong_heat")
        end
        warmth
      end

      # method to generate the text with temperature values
      # @return [String] the substring containing the temperature values and text conclusion
      def create_temperature_text
        text = I18n.t("forecast_text.apparent_temperature.text_maximum")
        text.concat((@extreme_values.maximum).ceil.to_s)
        text.concat(I18n.t("forecast_text.apparent_temperature.text_minimum"))
        text.concat((@extreme_values.minimum).floor.to_s)
        text.concat(I18n.t("forecast_text.apparent_temperature.text_finish"))
        text
      end
      
    end

  end

end
