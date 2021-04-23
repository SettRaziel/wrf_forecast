require 'ruby_utils/string'
require 'wrf_forecast'

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
