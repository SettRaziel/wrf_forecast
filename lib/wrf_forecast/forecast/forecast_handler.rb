require 'wrf_forecast/data'
require 'wrf_forecast/forecast/forecast_text'
require 'wrf_forecast/json_converter'
require 'wrf_forecast/threshold'

module WrfForecast

  # This class maintains the data and handler classes which are needed to generate
  # the forecast based on the given data
  class ForecastHandler

    # @return [ForecastText] the class creation the forecast text
    attr_reader :text

    # initialization
    # @param [WrfHandler] wrf_handler the wrf handler with the input data
    def initialize(wrf_handler)
      @repository = WrfForecast::ForecastRepository.new(wrf_handler)
      @threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(@repository)
      @wrf_handler = wrf_handler
      meta_data = wrf_handler.data_repository.meta_data
      @text = WrfForecast::ForecastText.new(meta_data, @repository, @threshold_handler)
    end

    # method to generate a json representation of the forecast data
    # @return [String] the json converted forecast information
    def generate_text_json_output
      @json_converter = WrfForecast::JsonConverter::TextForecastJsonConverter.
                        new(@wrf_handler.data_repository, @repository, @threshold_handler.warnings)
      @json_converter.convert
    end

    # method to generate a json representing the hourly values of forecast data
    # @return [String] the json converted forecast information
    def generate_hourly_json_output
      @json_converter = WrfForecast::JsonConverter::HourlyForecastJsonConverter.
                        new(@wrf_handler, @repository, @threshold_handler.warnings)
      @json_converter.convert
    end

    # method to return the created warnings
    # @return [Hash] the hash with the warnings
    def get_warnings
      threshold_handler.warnings
    end
    
    private

    # @return [ForecastJsonConverter] the json converter
    attr_reader :json_converter
    # @return [ForecastRepository] the repository with the rehashed forecast data
    attr_reader :repository
    # @return [ThresholdHandler] the handler with the threshold indicators
    attr_reader :threshold_handler
    # @return [WrfHandler] the wrf handler with the input data
    attr_reader :wrf_handler

  end

end
