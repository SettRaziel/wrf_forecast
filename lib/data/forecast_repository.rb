# @Author: Benjamin Held
# @Date:   2020-02-14 19:44:57
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-12 18:54:11

require 'ruby_utils/statistic'

class ForecastRepository
  
  # @return [Hash] the extreme values for the interval data
  attr_reader :extreme_values

  # @return [Hash] the forecast data identified by a symbol
  attr_reader :forecast_data

  # initialization
  # @params [WrfHandler] the wrf handler with the data
  def initialize(wrf_handler)
    @extreme_values = Hash.new()
    @forecast_data = Hash.new()
    @time_data = wrf_handler.retrieve_data_set(:forecast_time)

    add_temperature_data(wrf_handler)
    add_windspeed_data(wrf_handler)
  end

  private

  # @return [Array] the time stamp data
  attr_reader :time_data

  # method to add the temperature data und determine extreme values
  # @params [WrfHandler] the wrf handler with the data
  def add_temperature_data(wrf_handler)
    temperature = wrf_handler.retrieve_data_set(:air_temperature)
    @forecast_data[:air_temperature] = temperature
    @extreme_values[:air_temperature] = RubyUtils::Statistic.extreme_values(temperature)    
    nil
  end

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
    nil
  end

end  
