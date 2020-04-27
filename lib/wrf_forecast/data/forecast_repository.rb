# @Author: Benjamin Held
# @Date:   2020-02-14 19:44:57
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-27 14:38:54

require 'ruby_utils/statistic'
require 'wrf_forecast/data/wind_direction_repository'

module WrfForecast

  # This class contains all relevant forecast data that is required for
  # generating a forecast text
  class ForecastRepository
    
    # @return [Hash] the extreme values for the interval data
    attr_reader :extreme_values
    # @return [Hash] the forecast data identified by a symbol
    attr_reader :forecast_data
    # @return [Hash] the wind direction distribution
    attr_reader :direction_distribution
    # @return [Symbol] the prevalent wind direction
    attr_reader :prevalent_direction
    # @return [Array] the hourly rain sums
    attr_reader :hourly_rain

    # initialization
    # @param [WrfHandler] the wrf handler with the data
    def initialize(wrf_handler)
      @extreme_values = Hash.new()
      @forecast_data = Hash.new()
      @time_data = wrf_handler.retrieve_data_set(:forecast_time)

      add_temperature_data(wrf_handler)
      add_windspeed_data(wrf_handler)
      add_rain_data(wrf_handler)
    end

    private

    # @return [Array] the time stamp data
    attr_reader :time_data

    # method to add the temperature data und determine extreme values
    # @param [WrfHandler] wrf_handler the wrf handler with the data
    def add_temperature_data(wrf_handler)
      temperature = wrf_handler.retrieve_data_set(:air_temperature)
      @forecast_data[:air_temperature] = temperature
      @extreme_values[:air_temperature] = RubyUtils::Statistic.extreme_values(temperature)    
      nil
    end

    # method to add the wind data und determine extreme values for wind speed
    # @param [WrfHandler] wrf_handler the wrf handler with the data
    def add_windspeed_data(wrf_handler)
      r2d = 180.0 / (Math.atan(1) * 4.0)
      u_component = wrf_handler.retrieve_data_set(:u_wind)
      v_component = wrf_handler.retrieve_data_set(:v_wind)
      wind_speed = Array.new()
      wind_direction = Array.new()
      u_component.zip(v_component).each { |u, v| 
        wind_speed << Math.sqrt(u**2+v**2)
        wind_direction << Math.atan2(u, v) * r2d + 180
      }
      @forecast_data[:wind_speed] = wind_speed
      @forecast_data[:wind_direction] = wind_direction
      @extreme_values[:wind_speed] = RubyUtils::Statistic.extreme_values(wind_speed)
      generate_wind_direction_statistic
      nil
    end

    # method to determine the wind direction distribution for the given data
    def generate_wind_direction_statistic
      direction_repository = WrfForecast::WindDirectionRepository.new()
      direction_repository.generate_direction_distribution(@forecast_data[:wind_direction])
      @direction_distribution = direction_repository.direction_distribution
      @prevalent_direction = direction_repository.determine_prevalent_direction
      nil
    end

    # method to add the rain data from the two different sources
    # @param [WrfHandler] wrf_handler the wrf handler with the data
    def add_rain_data(wrf_handler)
      cumulus_rain = wrf_handler.retrieve_data_set(:cumulus_rainfall)
      explicit_rain = wrf_handler.retrieve_data_set(:explicit_rainfall)
      rain_data = Array.new()
      cumulus_rain.zip(explicit_rain).each { |c, e| 
        rain_data << c + e
      }
      @forecast_data[:rain] = rain_data
      calculate_hourly_rainsum
      nil
    end

    # method to sum up the rain data into hourly rain sums
    # for that calculate the difference from the rain value at the start and end
    # of the currently checked hour
    def calculate_hourly_rainsum
      rain_data = @forecast_data[:rain]
      @hourly_rain = Array.new()
      # when using an offset, start with the current value as delta
      previous_hour = rain_data[0]
      previous_timestamp = time_data[0].floor
      rain_data.zip(time_data).each { |rain, timestamp|
        # detect new hour, when the leading number increases by one
        if (timestamp.floor > previous_timestamp.floor)
          @hourly_rain << rain - previous_hour
          previous_hour = rain
        end
        previous_timestamp = timestamp
      }

      # workaround to satisfy the current requirement for daily values
      if (hourly_rain.size < 24)
        @hourly_rain << rain_data[rain_data.size-1] - previous_hour
      end
      @extreme_values[:rain] = RubyUtils::Statistic.extreme_values(@hourly_rain)
      nil
    end

  end  

end
