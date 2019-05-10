# @Author: Benjamin Held
# @Date:   2019-05-08 15:34:21
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-05-10 16:11:13

module WrfForecast

  require_relative '../parameter/parameter'
  require_relative '../help/help_output'
  require_relative '../wrf_library/data/wrf/wrf'
  
  # Dummy class to get access to the instance variables
  class << self
    # @return [DataRepository] the repository storing the datasets
    attr_reader :wrf_handler
    # @return [Parameter::ParameterHandler] the handler controlling
    #   the parameters
    attr_reader :parameter_handler
  end

  # singleton method to initialize the required repositories
  # @param [Array] arguments the input values from the terminal input ARGV
  def self.initialize_repositories(arguments)
      @parameter_handler = Parameter::ParameterHandler.new(arguments)
      filename = @parameter_handler.repository.parameters[:file]
      time = @parameter_handler.repository.parameters[:date]
      if (filename != nil && time != nil)
        @data_repo = Wrf::WrfHandler.new(filename, time)
      end
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
