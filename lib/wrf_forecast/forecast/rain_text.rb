module WrfForecast

  module Text

    # This class generates the forecast text for the rain data of the forecast
    # warings: all hourly warnings contain the lesser warnings as a subset, so only the worst 
    # hourly warning needs to be shown, the continous warning will be shown if the rain amount
    # sums up over 6 hours, if a hourly event also accours during the time both are shown
    class RainText < MeasurandText

      # initialization
      # @param [ExtremeValues] extreme_values the hourly rain extreme values
      # @param [Array] hourly_rain the hourly rain sums
      # @param [RainThreshold] thresholds the rain threshold
      def initialize(extreme_values, hourly_rain, thresholds)
        @hourly_rain = hourly_rain
        calculate_rainsum
        super(extreme_values, thresholds)
      end

      private

      # @return [Array] the hourly rain sums
      attr_reader :hourly_rain
      # @return [Float] the daily rain sum
      attr_reader :rain_sum

      # method to generate the forecast text for the rain
      def generate_forecast_text
        if (!shall_it_rain?)
          @text = I18n.t("forecast_text.rain.no_rain")
        else
          @text = I18n.t("forecast_text.rain.rain_start")
          @text.concat(create_intensity_text)
          @text.concat(create_rain_text)
        end
        nil
      end

      # method to generate the warning text for the measurand
      # @return [String] the warning text
      def generate_warning_text
        @warnings
      end

      # method to generate the text about the day
      # @return [String] the substring containing the rain intensity
      def create_intensity_text
        intensity = I18n.t("forecast_text.rain.intensity_normal")
        if (is_threshold_active?(:extreme_rain))
          intensity = I18n.t("forecast_text.rain.intensity_extreme")
        elsif (is_threshold_active?(:heavy_rain))
          intensity = I18n.t("forecast_text.rain.intensity_heavy")
        elsif (is_threshold_active?(:strong_rain))
          intensity = I18n.t("forecast_text.rain.intensity_strong")
        end

        if (@thresholds[:continous_rain].is_active)
          intensity = I18n.t("forecast_text.rain.intensity_continous")
          @warnings.concat"\n" if (!@warnings.empty?)
          @warnings.concat(@thresholds[:continous_rain].warning_text)
        end
        return intensity
      end

      # method to generate the text with rain values
      # @return [String] the substring containing the precipitation amount
      def create_rain_text
        text = I18n.t("forecast_text.rain.text_maximum")
        if (@thresholds[:continous_rain].is_active)
          text.concat(@rain_sum.ceil.to_s)
          text.concat(I18n.t("forecast_text.rain.text_continous"))
        else
          text.concat(@extreme_values.maximum.round(1).to_s)
          text.concat(I18n.t("forecast_text.rain.text_amount_hour"))
          text.concat(@rain_sum.ceil.to_s)
          text.concat(I18n.t("forecast_text.rain.text_amount_day"))
        end

        text.concat(I18n.t("forecast_text.rain.text_period_start"))
        if (@extreme_values.minimum.round(5) == 0.0)
          text.concat(I18n.t("forecast_text.rain.text_period_some_dry"))
        else
          text.concat(I18n.t("forecast_text.rain.text_period_no_dry"))
        end
        text.concat(I18n.t("forecast_text.rain.text_period_finish"))
        return text
      end

      # method to check if it should rain in the forecast time
      # @return [boolean] the information if it rains during the day
      def shall_it_rain?
        @hourly_rain.each { |value|
          return true if (value > 0.05)
        }
        return false
      end

      # method to calculate the total rain of the day
      def calculate_rainsum
        @rain_sum = 0
        @hourly_rain.each { |value|
          @rain_sum += value
        }
        nil
      end

    end

  end

end
