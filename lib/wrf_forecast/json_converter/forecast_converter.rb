module WrfForecast

  module JsonConverter

    # Child class to generate valid json output for the result data of a given wrf meteogram
    # result already stored in a data repository
    class ForecastJsonConverter < WrfForecast::JsonConverter::ForecastStationJsonConverter

      private

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
