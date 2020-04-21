# @Author: Benjamin Held
# @Date:   2019-05-08 15:34:21
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-21 17:33:35
  
require 'ruby_utils/parameter_converter'  
require 'wrf_library/wrf'
require 'wrf_forecast/parameter'
require 'wrf_forecast/help/help_output'
require 'wrf_forecast/forecast/forecast_handler'

# This module is the main entry point and will be called from the main forecast script
module WrfForecast
  
  # Dummy class to get access to the instance variables
  class << self

    # @return [WrfHandler] the repository storing the datasets
    attr_reader :wrf_handler
    # @return [Parameter::ParameterHandler] the handler controlling the parameters
    attr_reader :parameter_handler
    # @return [ForecastHandler] the handler for the rehashed forecast data
    attr_reader :forecast_handler

    # method to initialize the wrf handler based on the available parameter
    def initialize_wrf_handler
      if [@parameter_handler != nil]
        filename = @parameter_handler.repository.parameters[:file]
        time = @parameter_handler.repository.parameters[:date]
        # use 24 hours for a forecast right now to create a forecast text for a day

        if (contains_parameter?(:offset) && contains_parameter?(:period))
          period = RubyUtils::ParameterConverter.convert_float_parameter(
                 @parameter_handler.repository.parameters[:period])
          offset = RubyUtils::ParameterConverter.convert_float_parameter(
                 @parameter_handler.repository.parameters[:offset])
          @wrf_handler = WrfLibrary::Wrf::WrfHandler.new(filename, time, period, offset)
        elsif (@parameter_handler.repository.parameters[:period] != nil)
          period = RubyUtils::ParameterConverter.convert_float_parameter(
                 @parameter_handler.repository.parameters[:period])
          @wrf_handler = WrfLibrary::Wrf::WrfHandler.new(filename, time, period)
        else
          @wrf_handler = WrfLibrary::Wrf::WrfHandler.new(filename, time)
        end

      else
        raise ArgumentError, 'Error: Required input data is not initialized.'
      end
      nil
    end

    # method to initialize the forecast handler
    def initialize_forecast
      if (@wrf_handler != nil)
        @forecast_handler = WrfForecast::ForecastHandler.new(@wrf_handler)
      else
        raise ArgumentError, 'Error: Required forecast data is not initialized.'
      end
      nil
    end

    private

    # method the check if the given parameter has been set
    def contains_parameter?(symbol)
      @parameter_handler.repository.parameters[symbol] != nil
    end

  end

  # singleton method to initialize the parameter repositories
  # @param [Array] arguments the input values from the terminal input ARGV
  def self.initialize_parameter(arguments)
    @parameter_handler = Parameter::ParameterHandler.new(arguments)
  end

  # singleton method to initialize further required classes and create the forecast
  # @return [String] the created forecast text
  def self.output_forecast
    initialize_wrf_handler
    initialize_forecast
    @forecast_handler.forecast_text.get_complete_text
  end

  # call to print the help text
  def self.print_help
    WrfForecast::HelpOutput.print_help_for(@parameter_handler.repository.parameters[:help])
    nil
  end

  # call to print version number and author
  def self.print_version
    puts 'wrf_forecast version 0.1.1'.yellow
    puts 'Created by Benjamin Held (March 2019)'.yellow
    nil
  end

  # call for standard error output
  # @param [String] message message string with error message
  def self.print_error(message)
    puts "#{message}".red
    puts 'For help type: ruby <script> --help'.green
    nil
  end

end