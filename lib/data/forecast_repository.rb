# @Author: Benjamin Held
# @Date:   2020-02-14 19:44:57
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-09 18:26:46

require 'ruby_utils/statistic'

class ForecastRepository
  
  attr_reader :extreme_values

  attr_reader :forecast_data

  def initialize(wrf_handler)
    @extreme_values = Hash.new()
    @forecast_data = Hash.new()
    @time_data = wrf_handler.retrieve_data_set(:forecast_time)

    add_temperature_data(wrf_handler)
    add_windspeed_data(wrf_handler)
  end

  private

  attr_reader :time_data

  def add_temperature_data(wrf_handler)
    temperature = wrf_handler.retrieve_data_set(:air_temperature)
    @forecast_data[:air_temperature] = temperature
    @extreme_values[:air_temperature] = RubyUtils::Statistic.extreme_values(temperature)    
    nil
  end

  def add_windspeed_data(wrf_handler)
    u_component = wrf_handler.retrieve_data_set(:u_wind)
    v_component = wrf_handler.retrieve_data_set(:v_wind)
    wind_speed = Array.new()
    u_component.zip(v_component).each { |u, v| 
      wind_speed << Math.sqrt(u**2+v**2)
    }
    @forecast_data[:wind_speed] = wind_speed
    @extreme_values[:wind_speed] = RubyUtils::Statistic.extreme_values(wind_speed)
    nil
  end

end  
