#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-08-02 18:05:10
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-01-19 19:14:22

require "wrf_library/sun_equation"

module WrfForecast

  module JsonConverter

    # Child class to generate valid json output for the result data of a given wrf meteogram
    # result already stored in a data repository
    class ForecastJsonConverter < WrfLibrary::JsonConverter::BaseStationJsonConverter

      # initialization
      # @param [DataRepository] data the complete data
      # @param [ForecastRepository] forecast the specific forecast data
      # @param [Hash] warnings the mapping of measurand and triggered thresholds for the current forecast
      def initialize(data, forecast, warnings)
        @forecast = forecast
        @warnings = warnings
        super(data)
      end

      private

      # @return [ForecastRepository] the data repository with the forecast data
      attr_reader :forecast

      # @return [Hash] the mapping of measurand and triggered thresholds for the current forecast
      attr_reader :warnings

      # implementation of the abstract parent method. Since there is no additional data
      # the method returns an empty hash
      # @return [Hash] the key-value hash for the json output
      def add_additions
          date = @data.meta_data.start_date
          coordinate = @data.meta_data.station.coordinate
          sunrise = WrfLibrary::SunEquation.calculate_sunrise_time(date, coordinate.x, coordinate.y)
          sunset = WrfLibrary::SunEquation.calculate_sunset_time(date, coordinate.x, coordinate.y)
          { :suntime => { :sunrise => convert_suntime(date, sunrise), 
                          :sunset => convert_suntime(date, sunset) } }
      end

      # implementation of the abstract parent method to create valid json objects
      # for the stored data values
      # @return [Hash] the key-value hashes for the json output 
      def generate_data_values
        measurands = Hash.new()
        measurands[:temperature] = generate_temperature_values
        measurands[:wind_speed] = generate_wind_values
        measurands[:rain] = generate_rain_values
        measurands[:warnings] = generate_warnings
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

      # method to create the output array for the warnings
      def generate_warnings
        values = Array.new()
        @warnings.each_value { |value|
          value.each { |element|
            values << element.warning_text
          }
        }
        return values
      end

      # method to convert a float hourstamp to a valid time object
      # @param [Time] forecast_data the start date of the forecast
      # @param [Float] float_time the suntime hour as a float
      # @return [Time] the suntime as a time object
      def convert_suntime(forecast_date, float_time)
        hours = float_time.floor
        minutes = (float_time.round(2) % 1 * 60).round(0)
        Time.new(forecast_date.year, forecast_date.month, forecast_date.day, hours, minutes, 00, 
                 forecast_date.strftime("%:z"))
      end

    end

  end

end
