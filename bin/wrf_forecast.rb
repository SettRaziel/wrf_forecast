# @Author: Benjamin Held
# @Date:   2019-04-22 16:00:53
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-02-26 14:58:32

require 'ruby_utils/string'
require_relative '../lib/main/main_module'

begin
  WrfForecast::initialize_parameter(ARGV)
  parameter_handler = WrfForecast.parameter_handler
  
  WrfForecast.print_help() if (parameter_handler.repository.parameters[:help])
  if (parameter_handler.repository.parameters[:version])
    WrfForecast.print_version()
  end

  WrfForecast::initialize_wrf_handler

  puts WrfForecast.wrf_handler.data_repository.meta_data.inspect

rescue StandardError, NotImplementedError => e
    WrfForecast.print_error(e.message)
end
