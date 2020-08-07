#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-08-02 18:05:10
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-08-07 19:09:53

module WrfForecast

  module JsonConverter

    # Child class to generate valid json output for the result data of a given wrf meteogram
    # result already stored in a data repository
    class ForecastJsonConverter < WrfLibrary::JsonConverter::BaseStationJsonConverter

      # initialization
      # @param [DataRepository] data_repository the complete data
      # @param [ForecastRepository] forecast_repository the specific forecast data
      def initialize(data_repository, forecast_repository)
        @forecast = forecast_repository
        super(data_repository)
      end

      private

      # @return [ForecastRepository] the data repository with the forecast data
      attr_reader :forecast

      # implementation of the abstract parent method. In addition to the data stored by
      # the parent class, the wrf data also stores data aber the considered grid point
      # @return [Hash] the key-value hash for the json output
      def add_additions
        return Hash.new()
      end

      # implementation of the abstract parent method to create valid json objects
      # for the stored data values
      # @return [Hash] the key-value hashes for the json output 
      def generate_data_values
        measurands = Hash.new()
        measurands[:temperature] = generate_temperature_values
        measurands[:wind_speed] = generate_wind_values
        measurands[:rain] = generate_rain_values
        return measurands
      end

      # method to create the output hash for the temperature values
      def generate_temperature_values
        extreme_values = @forecast.extreme_values[:air_temperature]
        return { :minimum => extreme_values.minimum.round(3), 
                 :maximum => extreme_values.maximum.round(3) }
      end

      # method to create the output hash for the wind values
      def generate_wind_values
        extreme_values = @forecast.extreme_values[:wind_speed]
        prevalent_direction = WrfForecast::Directions.new().get_direction_string(@forecast.prevalent_direction)
        values = Hash.new()
        values[:minimum] = extreme_values.minimum.round(3)
        values[:maximum] = extreme_values.maximum.round(3)
        values[:prevalent_direction] = prevalent_direction
        return values
      end

      # method to create the output hash for the precipitation values
      def generate_rain_values
        extreme_values = @forecast.extreme_values[:rain]
        values = Hash.new()
        values[:minimum] = extreme_values.minimum.round(3)
        values[:maximum] = extreme_values.maximum.round(3)
        rain_sum = 0
        @forecast.hourly_rain.each { |value|
          rain_sum += value
        }
        values[:sum] = rain_sum.round(3)
        return values
      end

    end

  end

end
