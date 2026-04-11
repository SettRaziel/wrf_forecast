module WrfForecast

  # This module holds all classes that are used to convert forecast results into json objects
  module JsonConverter
    require 'wrf_library/json_converter'
    require 'wrf_forecast/json_converter/forecast_station_converter'
    require 'wrf_forecast/json_converter/hourly_forecast_converter'
    require 'wrf_forecast/json_converter/text_forecast_converter'
  end

end
