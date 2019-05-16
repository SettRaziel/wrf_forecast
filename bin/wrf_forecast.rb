# @Author: Benjamin Held
# @Date:   2019-04-22 16:00:53
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-05-16 17:56:54

require_relative '../lib/wrf_library/ruby_utils/string/string'
require_relative '../lib/main/main_module'

begin
  WrfForecast::initialize_repositories(ARGV)
  parameter_handler = WrfForecast.parameter_handler
  
  WrfForecast.print_help() if (parameter_handler.repository.parameters[:help])
  if (parameter_handler.repository.parameters[:version])
    WrfForecast.print_version()
  end

rescue StandardError, NotImplementedError => e
    WrfForecast.print_error(e.message)
end