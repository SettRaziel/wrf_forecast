# @Author: Benjamin Held
# @Date:   2019-05-08 15:34:21
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-20 16:40:52

module WrfForecast

  require 'wrf_library/wrf'
  require_relative './parameter'
  require_relative './help/help_output'
  
  # Dummy class to get access to the instance variables
  class << self
    # @return [WrfHandler] the repository storing the datasets
    attr_reader :wrf_handler
    # @return [Parameter::ParameterHandler] the handler controlling
    #   the parameters
    attr_reader :parameter_handler
  end


  # singleton method to initialize the parameter repositories
  # @param [Array] arguments the input values from the terminal input ARGV
  def self.initialize_parameter(arguments)
    @parameter_handler = Parameter::ParameterHandler.new(arguments)
  end

  # singleton method to initialize the wrf handler
  def self.initialize_wrf_handler
      filename = @parameter_handler.repository.parameters[:file]
      time = @parameter_handler.repository.parameters[:date]
      @wrf_handler = WrfLibrary::Wrf::WrfHandler.new(filename, time)
  end

  # call to print the help text
  def self.print_help
    HelpOutput.print_help_for(@parameter_handler.repository.parameters[:help])
    exit(0)
  end

  # call to print version number and author
  def self.print_version
    puts 'wrf_forecast version 0.0.1'.yellow
    puts 'Created by Benjamin Held (March 2019)'.yellow
    exit(0)
  end

  # call for standard error output
  # @param [String] message message string with error message
  def self.print_error(message)
    puts "#{message}".red
    puts 'For help type: ruby <script> --help'.green
    exit(0)
  end

end
