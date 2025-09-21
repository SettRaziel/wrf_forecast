require "wrf_forecast/json_converter"

module WrfForecast

  module JsonConverter

    # Child class to generate valid json output for the result data of a given wrf meteogram
    # result already stored in a data repository
    class FaultyForecastJsonConverter < WrfForecast::JsonConverter::ForecastStationJsonConverter

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
      # @return [Array] the array with the hourly temperature values
      def generate_apparent_temperature_values
        timestamps = @wrf_handler.retrieve_data_set(:forecast_time)
        data = @forecast.forecast_data[:apparent_temperature]
        WrfLibrary::Statistic::Hourly.calculate_hourly_data_means(timestamps, data)
      end

      # method to create the output hash for the air temperature values
      # @return [Array] the array with the hourly temperature values
      def generate_air_temperature_values
        WrfLibrary::Statistic::Hourly.calculate_hourly_means(:air_temperature, @wrf_handler)
      end

      # method to create the output hash for the pressure values
      # @return [Array] the array with the hourly pressure values
      def generate_pressure_values
        WrfLibrary::Statistic::Hourly.calculate_hourly_means(:pressure, @wrf_handler)
      end

      # method to create the output hash for the wind values
      # @return [Array] the array with the hourly wind values
      def generate_windspeed_values
        WrfLibrary::Statistic::Hourly.calculate_hourly_windspeed_means(@wrf_handler)
      end

      # method to create the output hash for the precipitation values
      # @return [Array] the array with the hourly precipitation values
      def generate_rain_values
        WrfLibrary::Statistic::Hourly.calculate_hourly_rainsum(@wrf_handler)        
      end

    end

  end

end
