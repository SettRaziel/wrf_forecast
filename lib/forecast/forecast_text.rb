#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-22 10:46:55
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-30 09:45:49

require 'wrf_library/wrf'
require_relative '../data/forecast_repository'
require_relative '../threshold'
require_relative './english/temperature/temperature_text'
require_relative './english/wind/wind_text'
require_relative './english/rain/rain_text'

# This class handles the creation of the combined forecast text for the given input
class ForecastText

  # @return [String] the forecast text for given forecast data
  attr_reader :forecast_text

  # initialization
  # @param [WrfMetaData] meta_data the meta data for the forecast
  # @param [ForecastRepository] forecast_repository the repository with
  # the rehashed forecast data
  # @param [ThresholdHandler] threshold_handler the handler with the indicators
  def initialize(meta_data, forecast_repository, threshold_handler)
    initialize_temperature_text(forecast_repository, threshold_handler)
    initialize_wind_text(forecast_repository, threshold_handler)
    initialize_rain_text(forecast_repository, threshold_handler)
    generate_forecast_text(meta_data)
  end

  private

  # @return [TemperatureText] the class generating the temperature forecast
  attr_reader :temperature_text
  # @return [WindText] the class generating the wind forecast
  attr_reader :wind_text
  # @return [RainText] the class generating the rain forecast
  attr_reader :rain_text

  # method to create the forcast text based on the data and meta information
  def generate_forecast_text(meta_data)
    station = meta_data.station
    start_date = meta_data.start_date
    @forecast_text = 'Weather forecast of '
    @forecast_text.concat(station.name)
    @forecast_text.concat(' for the ')
    @forecast_text.concat(start_date.to_s)
    @forecast_text.concat(".\n\n")
    @forecast_text.concat(@temperature_text.forecast_text).concat("\n")
    @forecast_text.concat(@wind_text.forecast_text).concat("\n")
    @forecast_text.concat(@rain_text.forecast_text)
  end

  # method to create the text for the air temperature
  # @param [ForecastRepository] repository the repository with
  # the rehashed forecast data
  # @param [ThresholdHandler] handler the handler with the indicators
  def initialize_temperature_text(repository, handler)
    extreme_values = repository.extreme_values[:air_temperature]
    threshold = handler.temperature_threshold.indicators
    @temperature_text = TemperatureText.new(extreme_values, threshold)
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
    @wind_text = WindText.new(extreme_values, prevalent_direction, threshold)
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
    @rain_text = RainText.new(extreme_values, hourly_rain, threshold)
    nil
  end

end
