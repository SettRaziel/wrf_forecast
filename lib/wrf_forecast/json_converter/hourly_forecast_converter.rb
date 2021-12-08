require "wrf_library/statistic"

module WrfForecast

  module JsonConverter

    # Child class to generate valid json output for the result data of a given wrf meteogram
    # result already stored in a data repository
    class HourlyForecastJsonConverter < WrfForecast::JsonConverter::ForecastStationJsonConverter

      # initialization
      # @param [WrfHandler] wrf_handler the wrf handler with the input data
      # @param [ForecastRepository] forecast the specific forecast data
      # @param [Hash] warnings the mapping of measurand and triggered thresholds for the current forecast
      def initialize(wrf_handler, forecast, warnings)
        @wrf_handler = wrf_handler
        super(wrf_handler.data_repository, forecast, warnings)
      end

      private

      # @return [WrfHandler] the wrf handler with the data of the model run
      attr_accessor :wrf_handler

      # method to create the output hash for the temperature values
      def generate_temperature_values
        WrfLibrary::Statistic::Hourly.calculate_hourly_means(:air_temperature, @wrf_handler)
      end

      # method to create the output hash for the wind values
      def generate_wind_values
        WrfLibrary::Statistic::Hourly.calculate_hourly_windspeed_means(@wrf_handler)
      end

      # method to create the output hash for the precipitation values
      def generate_rain_values
        WrfLibrary::Statistic::Hourly.calculate_hourly_rainsum(@wrf_handler)        
      end

    end

  end

end
