# @Author: Benjamin Held
# @Date:   2015-06-12 10:45:36
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-04-24 19:25:14

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
        when '-d', '--date'
          create_argument_entry(:type, unflagged_arguments)
        when /-[a-z]|--[a-z]+/ then raise_invalid_parameter(arg)
      else
        raise_invalid_parameter(arg)
      end
      nil
    end

  end

end
