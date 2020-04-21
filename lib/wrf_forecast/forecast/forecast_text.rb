#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-22 10:46:55
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-21 19:33:02

require 'wrf_library/wrf'
require 'wrf_forecast/data/forecast_repository'
require 'wrf_forecast/threshold'
require 'wrf_forecast/forecast/english/temperature/temperature_text'
require 'wrf_forecast/forecast/english/wind/wind_text'
require 'wrf_forecast/forecast/english/rain/rain_text'

module WrfForecast

  # This class handles the creation of the combined forecast text for the given input
  class ForecastText

    # @return [String] a copy of the forecast header text
    attr_reader :header
    # @return [String] a copy of the forecast body text
    attr_reader :body

    # initialization
    # @param [WrfMetaData] meta_data the meta data for the forecast
    # @param [ForecastRepository] forecast_repository the repository with
    # the rehashed forecast data
    # @param [ThresholdHandler] threshold_handler the handler with the indicators
    def initialize(meta_data, forecast_repository, threshold_handler)
      initialize_temperature_text(forecast_repository, threshold_handler)
      initialize_wind_text(forecast_repository, threshold_handler)
      initialize_rain_text(forecast_repository, threshold_handler)
      create_header(meta_data)
      create_body
    end

    # method to create the complete forecast text
    # @return [String] the combined forecast text
    def get_complete_text
      text = @header.dup
      text.concat(".\n\n")
      text.concat(@body)
    end

    private

    # @return [TemperatureText] the class generating the temperature forecast
    attr_reader :temperature_text
    # @return [WindText] the class generating the wind forecast
    attr_reader :wind_text
    # @return [RainText] the class generating the rain forecast
    attr_reader :rain_text

    # method to create the header line for the text forecast
    # @param [WrfMetaData] meta_data the meta data for the forecast
    def create_header(meta_data)
      station = meta_data.station
      start_date = meta_data.start_date
      @header = 'Weather forecast of '
      @header.concat(station.name)
      @header.concat(' for the ')
      @header.concat(start_date.to_s)
      nil
    end

    # method to create the body text for the text forecast
    def create_body
      @body = @temperature_text.text.concat("\n")
      @body.concat(@wind_text.text).concat("\n")
      @body.concat(@rain_text.text)
      nil
    end

    # method to create the text for the air temperature
    # @param [ForecastRepository] repository the repository with
    # the rehashed forecast data
    # @param [ThresholdHandler] handler the handler with the indicators
    def initialize_temperature_text(repository, handler)
      extreme_values = repository.extreme_values[:air_temperature]
      threshold = handler.temperature_threshold.indicators
      @temperature_text = WrfForecast::TemperatureText.new(extreme_values, threshold)
      nil
    end

    # method to create the text for the wind
    # @param [ForecastRepository] repository the repository with
    # the rehashed forecast data
    # @param [ThresholdHandler] handler the handler with the indicators
    def initialize_wind_text(repository, handler)
      extreme_values = repository.extreme_values[:wind_speed]
      prevalent_direction = repository.prevalent_direction
      threshold = handler.wind_threshold.indicators
      @wind_text = WrfForecast::WindText.new(extreme_values, prevalent_direction, threshold)
      nil
    end

    # method to create the text for the precipitation
    # @param [ForecastRepository] repository the repository with
    # the rehashed forecast data
    # @param [ThresholdHandler] handler the handler with the indicators
    def initialize_rain_text(repository, handler)
      extreme_values = repository.extreme_values[:rain]
      hourly_rain = repository.hourly_rain
      threshold = handler.rain_threshold.indicators
      @rain_text = WrfForecast::RainText.new(extreme_values, hourly_rain, threshold)
      nil
    end

  end

end
