# @Author: Benjamin Held
# @Date:   2015-06-12 10:45:36
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-06-30 12:39:41

# Parent module which holdes the classes dealing with reading and validating
# the provided input parameters
module Parameter

  # Parameter repository to store the valid parameters of the script.
  # {#initialize} gets the provided parameters and fills a hash which
  # grants access to the provided parameters and arguments.
  class ParameterRepository < BaseParameterRepository

    private

    # method to read further argument and process it depending on its content
    # @param [String] arg the given argument
    # @param [Array] unflagged_arguments the argument array
    def process_argument(arg, unflagged_arguments)
      case arg
        when *@mapping[:date] then create_argument_entry(:date, unflagged_arguments)
        when *@mapping[:period] then create_argument_entry(:period, unflagged_arguments)
        when /-[a-z]|--[a-z]+/ then raise_invalid_parameter(arg)
      else
        raise_invalid_parameter(arg)
      end
      nil
    end

    # method to define the input string values that will match a given paramter symbol
    def define_mapping
      @mapping[:date] = ['-d', '--date']
      @mapping[:period] = ['-p', '--period']
    end

  end

end
