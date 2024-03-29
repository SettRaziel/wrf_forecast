require "time"
require "pathname"
require "ruby_utils/parameter_converter"
require "wrf_library/wrf"
require "wrf_forecast/parameter"
require "wrf_forecast/help/help_output"
require "wrf_forecast/forecast/forecast_handler"
require "wrf_forecast/locale_configuration"

# This module is the main entry point and will be called from the main forecast script
module WrfForecast
  
  # Dummy class to get access to the instance variables
  class << self

    # @return [Handler] the repository storing the datasets
    attr_reader :wrf_handler
    # @return [Parameter::ParameterHandler] the handler controlling the parameters
    attr_reader :parameter_handler
    # @return [ForecastHandler] the handler for the rehashed forecast data
    attr_reader :forecast_handler

    # main entry point and initialization
    # @param [Array] arguments the input values from the terminal input ARGV
    def initialize(arguments)
      @parameter_handler = WrfForecast::Parameter::ParameterHandler.new(arguments)
      initialize_locale

      if (!parameter_handler.repository.parameters[:help] && 
          !parameter_handler.repository.parameters[:version])
        initialize_wrf_handler
        initialize_forecast
      else
        @wrf_handler = nil
        @forecast_handler = nil
      end
    end

    private

    # method to initialize the wrf handler based on the available parameter
    def initialize_wrf_handler
      filename = @parameter_handler.repository.parameters[:file]
      time = Time.parse(@parameter_handler.repository.parameters[:date])
      # use 24 hours for a forecast right now to create a forecast text for a day

      if (contains_parameter?(:offset) && contains_parameter?(:period))
        period = RubyUtils::ParameterConverter.convert_float_parameter(
               @parameter_handler.repository.parameters[:period])
        offset = RubyUtils::ParameterConverter.convert_float_parameter(
               @parameter_handler.repository.parameters[:offset])
        @wrf_handler = WrfLibrary::Wrf::Handler.new(filename, time, period, offset)
      elsif (@parameter_handler.repository.parameters[:period] != nil)
        period = RubyUtils::ParameterConverter.convert_float_parameter(
               @parameter_handler.repository.parameters[:period])
        @wrf_handler = WrfLibrary::Wrf::Handler.new(filename, time, period)
      else
        @wrf_handler = WrfLibrary::Wrf::Handler.new(filename, time)
      end
      nil
    end

    # method to initialize the forecast handler
    def initialize_forecast
      @forecast_handler = WrfForecast::ForecastHandler.new(@wrf_handler)
      nil
    end

    # method the check if the given parameter has been set
    def contains_parameter?(symbol)
      @parameter_handler.repository.parameters[symbol] != nil
    end

    # method to laod the available locale files and set a specific locale
    # if the locale parameter is set
    def initialize_locale
      WrfForecast::LocaleConfiguration.initialize_locale(
        Pathname.new(__dir__).join("../config/locales").expand_path)
      if (contains_parameter?(:locale))
        locale_string = @parameter_handler.repository.parameters[:locale]
        WrfForecast::LocaleConfiguration.determine_locale(locale_string)
      end
      nil
    end

  end

  # method to return the warnings of the current forecast
  # @return [Hash] if initialized the warning hash, else nil
  def self.get_warnings
    if (@forecast_handler != nil)
      return @forecast_handler.get_warnings
    else
      print_error("Error: Module not initialized. Run WrfForecast.new(ARGV)")
    end
    nil
  end    

  # singleton method check for the forecast handler and return the forecast based
  # on the given parameters
  # @return [String] if initialized the created forecast text, else nil
  def self.output_forecast
    if (@forecast_handler != nil)
      if (@parameter_handler.repository.parameters[:json])
        output = determine_json_output
      else
        output = @forecast_handler.text.get_complete_text
        output.concat("\n\n").concat(@forecast_handler.text.warnings)
      end
      save_forecast(output)
      return output
    else
      print_error("Error: Module not initialized. Run WrfForecast.new(ARGV)")
    end
    nil
  end

  # singleton method to save the forecast output if the given parameter is set
  # @param [String] output the output that should be saved
  def self.save_forecast(output)
    if (contains_parameter?(:save))
      if (output != nil)
        file = File.open(@parameter_handler.repository.parameters[:save], "w")
        file.write(output)
        file.close
      else
        print_error("Error: No output was generated or it is nil.")
      end
    end
    nil
  end

  # call to print the help text
  def self.print_help
    if (@parameter_handler != nil && @parameter_handler.repository.parameters[:help] != nil)
      WrfForecast::HelpOutput.print_help_for(@parameter_handler.repository.parameters[:help])
    else
      print_error("Error: Module not initialized. Run WrfForecast.new(ARGV)")
    end
    nil
  end

  # call to print version number and author
  def self.print_version
    puts "wrf_forecast version 0.3.0".yellow
    puts "Created by Benjamin Held (March 2019)".yellow
    nil
  end

  # call for standard error output
  # @param [String] message message string with error message
  def self.print_error(message)
    puts "#{message}".red
    puts "For help type: ruby <script> --help".green
    nil
  end

  # private method to determine which kind of json output needs to be created,
  # based on the given script parameter json and aggregate
  private_class_method def self.determine_json_output
    if (@parameter_handler.repository.parameters[:aggregate])
      return @forecast_handler.generate_hourly_json_output          
    end
    @forecast_handler.generate_text_json_output
  end

end
