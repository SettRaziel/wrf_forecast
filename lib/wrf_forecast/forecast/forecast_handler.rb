#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-21 17:34:42
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-08-06 19:34:08

require 'wrf_forecast/data'
require 'wrf_forecast/threshold'
require 'wrf_forecast/forecast/forecast_text'

module WrfForecast

  # This class maintains the data and handler classes which are needed to generate
  # the forecast based on the given data
  class ForecastHandler

    # @return [ForecastRepository] the repository with the rehashed forecast data
    attr_reader :repository
    # @return [ThresholdHandler] the handler with the threshold indicators
    attr_reader :threshold_handler
    # @return [ForecastText] the class creation the forecast text
    attr_reader :text

    # initialization
    # @param [WrfHandler] wrf_handler the wrf handler with the input data
    def initialize(wrf_handler)
      @repository = WrfForecast::ForecastRepository.new(wrf_handler)
      @threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(@repository)
      meta_data = wrf_handler.data_repository.meta_data
      @text = WrfForecast::ForecastText.new(meta_data, @repository, @threshold_handler)
    end

  end

end
