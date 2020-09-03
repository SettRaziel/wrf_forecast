# @Author: Benjamin Held
# @Date:   2015-06-12 10:45:36
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-08-20 10:11:29

module WrfForecast

  # Parent module which holdes the classes dealing with reading and validating
  # the provided input parameters
  module Parameter

    # Parameter repository to store the valid parameters of the script.
    # {#initialize} gets the provided parameters and fills a hash which
    # grants access to the provided parameters and arguments.
    class ParameterRepository < RubyUtils::Parameter::BaseParameterRepository

      private

      # method to read further argument and process it depending on its content
      # @param [String] arg the given argument
      def process_argument(arg)
        case arg
          when *@mapping[:date] then create_argument_entry(:date)
          when *@mapping[:default] then create_defaults
          when *@mapping[:json] then @parameters[:json] = true
          when *@mapping[:offset] then create_argument_entry(:offset)
          when *@mapping[:period] then create_argument_entry(:period)
          when *@mapping[:save] then create_argument_entry(:save)
        else
          raise_invalid_parameter(arg)
        end
        nil
      end

      # method to define the input string values that will match a given paramter symbol
      def define_mapping
        @mapping[:date] = ["-d", "--date"]
        @mapping[:default] = ["--default"]
        @mapping[:json] = ["-j", "--json"]
        @mapping[:offset] = ["-o", "--offset"]
        @mapping[:period] = ["-p", "--period"]
        @mapping[:save] = ["-s", "--save"]
      end

      # method to set the default values when parameter --default is set
      def create_defaults
        @parameters[:date] = Time.parse("00:00").to_s
        @parameters[:period] = "24"
        @parameters[:default] = true
      end

    end

  end

end
