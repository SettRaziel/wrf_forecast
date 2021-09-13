require 'wrf_forecast/data'
require 'wrf_forecast/forecast/forecast_text'
require 'wrf_forecast/json_converter'
require 'wrf_forecast/threshold'

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
      @json_converter = WrfForecast::JsonConverter::TextForecastJsonConverter.
                        new(wrf_handler.data_repository, repository, @threshold_handler.warnings)
    end

    # method to generate a json representation of the forecast data
    # @return [String] the json converted forecast information
    def generate_json_output
      @json_converter.convert
    end
    
    private

    # @return [ForecastJsonConverter] the json converter
    attr_reader :json_converter

  end

end
