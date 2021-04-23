require 'wrf_forecast/data/directions'

module WrfForecast

  module Text

    # This class generates the forecast text for the wind speed
    # and direction of the forecast
    # warnings: all lesser warnings are a subset of the highest warning, that means
    # only the worst warning needs to be shown, that can be done during text creation
    class WindText < MeasurandText

      # initialization
      # @param [ExtremeValues] extreme_values the wind extreme values
      # @param [Symbol] prevalent_direction the prevalent wind direction
      # @param [WindThreshold] thresholds the wind threshold
      def initialize(extreme_values, prevalent_direction, thresholds)
        @prevalent_direction = prevalent_direction
        super(extreme_values, thresholds)
      end

      private

      # @return [Symbol] the prevalent wind direction
      attr_reader :prevalent_direction

      # method to generate the forecast text for the wind
      def generate_forecast_text
        @text = I18n.t("forecast_text.wind.text_start")
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
        wind_strength = I18n.t("forecast_text.wind.strength_normal")
        if (is_threshold_active?(:hurricane_day))
         wind_strength = I18n.t("forecast_text.wind.strength_extremly_stormy")
        elsif (is_threshold_active?(:storm_day))
          wind_strength = I18n.t("forecast_text.wind.strength_very_stormy")
        elsif (is_threshold_active?(:storm_squall_day))
          wind_strength = I18n.t("forecast_text.wind.strength_stormy")
        elsif (is_threshold_active?(:squall_day))
          wind_strength = I18n.t("forecast_text.wind.strength_squall")
        elsif (is_threshold_active?(:windy_day))
          wind_strength = I18n.t("forecast_text.wind.strength_windy")
        end
        return wind_strength
      end

      # method to generate the text with wind values
      def create_wind_text
        text = I18n.t("forecast_text.wind.text_maximum")
        text.concat((@extreme_values.maximum * 3.6).ceil.to_s)
        text.concat(I18n.t("forecast_text.wind.text_maximum_unit"))
        text.concat(create_prevalent_direction_text)
        text.concat(I18n.t("forecast_text.wind.text_mean"))
        mean = (@extreme_values.maximum + @extreme_values.minimum) / 2.0
        text.concat((mean * 3.6).ceil.to_s)
        text.concat(I18n.t("forecast_text.wind.text_finish"))
        return text
      end

      # method to create the text for the prevalent wind direction
      def create_prevalent_direction_text
        if (@prevalent_direction == nil)
          return I18n.t("forecast_text.wind.direction_circular")
        end
        return WrfForecast::Directions.new().get_direction_string(@prevalent_direction)
      end

    end

  end

end
