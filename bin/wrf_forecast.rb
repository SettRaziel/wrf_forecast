# @Author: Benjamin Held
# @Date:   2019-04-22 16:00:53
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-05-04 22:11:01

require 'ruby_utils/string'
require_relative '../lib/wrf_forecast'

begin
  WrfForecast.initialize(ARGV)
  parameter_handler = WrfForecast.parameter_handler
  
  if (parameter_handler.repository.parameters[:help])
    WrfForecast.print_help
  elsif (parameter_handler.repository.parameters[:version])
    WrfForecast.print_version
  else
    puts WrfForecast.output_forecast
  end

rescue StandardError, NotImplementedError => e
  WrfForecast.print_error(e.message)
end
