#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-21 17:38:16
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-21 18:30:34

require_relative '../data/forecast_repository'

module Threshold

  # This class maintains the different threshold classes and initializes them with
  # the data of the forecast repository.
  class ThresholdHandler

    # @return [TemperatureThreshold] the class holding the temperature thresholds
    attr_reader :temperature_threshold
    # @return [WindThreshold] the class holding the wind thresholds
    attr_reader :wind_threshold
    # @return [RainThreshold] the class holding the rain thresholds
    attr_reader :rain_threshold

    # initialization
    # @param [ForecastRepository] the forecast repository holding the forecast data
    def initialize(forecast_repository)
      data = forecast_repository.forecast_data
      @temperature_threshold = TemperatureThreshold.new(data[:air_temperature])
      @wind_threshold = WindThreshold.new(data[:wind_speed])
      @rain_threshold = RainThreshold.new(forecast_repository.hourly_rain)
    end

  end

end
