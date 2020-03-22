# @Author: Benjamin Held
# @Date:   2019-05-08 15:34:21
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-22 11:27:15
  
require 'wrf_library/wrf'
require_relative './parameter'
require_relative './help/help_output'
require_relative './forecast/forecast_handler'

module WrfForecast
  
  # Dummy class to get access to the instance variables
  class << self
    # @return [WrfHandler] the repository storing the datasets
    attr_reader :wrf_handler
    # @return [Parameter::ParameterHandler] the handler controlling the parameters
    attr_reader :parameter_handler
    # @return [ForecastHandler] the handler for the rehashed forecast data
    attr_reader :forecast_handler
  end

  # singleton method to initialize the parameter repositories
  # @param [Array] arguments the input values from the terminal input ARGV
  def self.initialize_parameter(arguments)
    @parameter_handler = Parameter::ParameterHandler.new(arguments)
    initialize_wrf_handler
    initialize_forecast
  end

  # singleton method to initialize the wrf handler
  def self.initialize_wrf_handler
    if [@parameter_handler != nil]
      filename = @parameter_handler.repository.parameters[:file]
      time = @parameter_handler.repository.parameters[:date]
      @wrf_handler = WrfLibrary::Wrf::WrfHandler.new(filename, time)
    else
      raise ArgumentError, 'Error: Required input data is not initialized.'
    end
  end

  # singleton method to initialize the forecast handler
  def self.initialize_forecast
    if (@wrf_handler != nil)
      @forecast_handler = ForecastHandler.new(@wrf_handler)
    else
      raise ArgumentError, 'Error: Required forecast data is not initialized.'
    end
  end

  # call to print the help text
  def self.print_help
    HelpOutput.print_help_for(@parameter_handler.repository.parameters[:help])
  end

  # call to print version number and author
  def self.print_version
    puts 'wrf_forecast version 0.0.1'.yellow
    puts 'Created by Benjamin Held (March 2019)'.yellow
  end

  # call for standard error output
  # @param [String] message message string with error message
  def self.print_error(message)
    puts "#{message}".red
    puts 'For help type: ruby <script> --help'.green
  end

end
