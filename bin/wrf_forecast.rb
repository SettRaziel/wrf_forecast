# @Author: Benjamin Held
# @Date:   2019-04-22 16:00:53
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-28 15:45:29

require 'ruby_utils/string'
require_relative '../lib/main_module'

begin
  WrfForecast::initialize_parameter(ARGV)
  parameter_handler = WrfForecast.parameter_handler
  
  if (parameter_handler.repository.parameters[:help])
    WrfForecast.print_help
  elsif (parameter_handler.repository.parameters[:version])
    WrfForecast.print_version
  else
    WrfForecast.output_forecast
  end

rescue StandardError, NotImplementedError => e
    WrfForecast.print_error(e.message)
end
