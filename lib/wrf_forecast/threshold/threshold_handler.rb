require "wrf_forecast/data/forecast_repository"

module WrfForecast

  module Threshold

    # This class maintains the different threshold classes and initializes them with
    # the data of the forecast repository.
    class ThresholdHandler

      # @return [TemperatureThreshold] the class holding the temperature thresholds
      attr_reader :temperature_threshold
      # @return [WindThreshold] the class holding the wind thresholds
      attr_reader :wind_threshold
      # @return [RainThreshold] the class holding the rain thresholds
      attr_reader :rain_threshold
      # @return [Hash] the mapping of measurand and triggered thresholds for the current forecast
      attr_reader :warnings

      # initialization
      # @param [ForecastRepository] forecast_repository the forecast repository holding the forecast data
      def initialize(forecast_repository)
        data = forecast_repository.forecast_data
        @temperature_threshold = WrfForecast::Threshold::TemperatureThreshold.new(data[:air_temperature])
        @wind_threshold = WrfForecast::Threshold::WindThreshold.new(data[:wind_speed])
        @rain_threshold = WrfForecast::Threshold::RainThreshold.new(forecast_repository.hourly_rain)
        collect_active_thresholds
      end

      private

      # method to collect all overstepped thresholds indicating significant weather
      def collect_active_thresholds
        @warnings = Hash.new()
        @warnings[:air_temperature] = collect_thresholds_for(@temperature_threshold)
        @warnings[:wind_speed] = collect_thresholds_for(@wind_threshold)
        @warnings[:rain] = collect_thresholds_for(@rain_threshold)
        nil
      end

      # method to collect the overstepped thresholds for the given measurand threshold
      def collect_thresholds_for(threshold)
        active_thresholds = Array.new()
        threshold.indicators.each_value { |value| 
          active_thresholds << value if(value.is_active)
        }
        return active_thresholds
      end

    end

  end

end
