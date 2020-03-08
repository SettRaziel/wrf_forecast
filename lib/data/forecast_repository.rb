# @Author: Benjamin Held
# @Date:   2020-02-14 19:44:57
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-08 18:56:19

require 'ruby_utils/statistic'

class ForecastRepository
  
  attr_reader :extreme_values

  attr_reader :forecast_data

  def initialize(wrf_handler)
    @extreme_values = Hash.new()
    @forecast_data = Hash.new()
    @time_data = wrf_handler.retrieve_data_set(:forecast_time)

    add_temperature_measurement_data(wrf_handler)
  end

  private

  attr_reader :time_data

  def add_temperature_measurement_data(wrf_handler)
    @forecast_data[:air_temperature] = wrf_handler.retrieve_data_set(:air_temperature)
    determine_extreme_values(:air_temperature)
  end

  # determine minimal and maximal values for the given measurand
  def determine_extreme_values(measurand)
    extreme_values = RubyUtils::Statistic.extreme_values(@forecast_data[measurand])
    @extreme_values[measurand] = extreme_values
  end

end  
