#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-21 17:34:42
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-27 19:30:32

require_relative '../data/forecast_repository'
require_relative '../threshold'

# This class maintains the data and handler classes which are needed to generate
# the forecast based on the given data
class ForecastHandler

  # @return [ForecastRepository] the repository with the rehashed forecast data
  attr_reader :forecast_repository
  # @return [ThresholdHandler] the handler with the threshold indicators
  attr_reader :threshold_handler
  # @return [ForecastText] the class creation the forecast text
  attr_reader :forecast_text

  # initialization
  # @param [WrfHandler] wrf_handler the wrf handler with the input data
  def initialize(wrf_handler)
    @forecast_repository = ForecastRepository.new(wrf_handler)
    @threshold_handler = Threshold::ThresholdHandler.new(@forecast_repository)
    meta_data = wrf_handler.data_repository.meta_data
    @forecast_text = ForecastText.new(meta_data, @forecast_repository, 
                                      @threshold_handler)
  end

end
