module WrfForecast

  module Text

    # This class generates the forecast text for the pressure data of the forecast
    # warnings: no warnings at the moment
    class PressureText < MeasurandText

      # initialization
      # @param [ExtremeValues] extreme_values the pressure extreme values
      # @param [Array] pressure_data the pressure data
      # @param [WindThreshold] thresholds the pressure threshold
      def initialize(extreme_values, pressure_data, thresholds)
        @pressure_mean = (pressure_data.sum(0.0) / (pressure_data.size * 100)).round(1)
        super(extreme_values, thresholds)
      end

      private

      # @return [Float] the mean value of the pressure dataset
      attr_reader :pressure_mean

      # method to generate the forecast text for the air pressure
      def generate_forecast_text
        @text = I18n.t("forecast_text.pressure.text_start")
        @text.concat(create_attribute_text).concat(I18n.t("forecast_text.pressure.text_with"))
        @text.concat(@pressure_mean.to_s).concat(I18n.t("forecast_text.pressure.text_continue"))
        @text.concat(create_pressure_text)
        nil
      end

      # method to generate the warning text for the measurand
      def generate_warning_text
        # no warning criterias
        @warnings
      end

      # method to generate the text about the day
      def create_attribute_text
        attribute = I18n.t("forecast_text.pressure.level_normal")
        if (is_threshold_active?(:very_low_pressure))
          attribute = I18n.t("forecast_text.pressure.level_very_low")
        elsif (is_threshold_active?(:low_pressure))
          attribute = I18n.t("forecast_text.pressure.level_low")
        elsif (is_threshold_active?(:very_high_pressure))
          attribute = I18n.t("forecast_text.pressure.level_very_high")
        elsif (is_threshold_active?(:high_pressure))
          attribute = I18n.t("forecast_text.pressure.level_high")
        end
        attribute
      end

      # method to generate the text with air pressure values
      def create_pressure_text
        text = I18n.t("forecast_text.pressure.text_maximum")
        text.concat((@extreme_values.maximum / 100).ceil.to_s)
        text.concat(I18n.t("forecast_text.pressure.text_minimum"))
        text.concat((@extreme_values.minimum / 100).floor.to_s)
        text.concat(I18n.t("forecast_text.pressure.text_finish"))
        text
      end
      
    end

  end

end
