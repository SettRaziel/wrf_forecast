# @Author: Benjamin Held
# @Date:   2015-07-20 11:23:58
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-06-29 15:23:11

module Parameter

  # class to seperate the storage of the parameter in a repository entity and
  # checking for valid parameter combination as part of the application logic.
  class ParameterHandler < BaseParameterHandler

    # method to initialize the correct repository that should be used 
    # in this handler
    # @param [Array] argv array of input parameters
    def initialize_repository(argv)
      @repository = ParameterRepository.new(argv)
    end

    private

    # private method with calls of the different validations methods
    def validate_parameters
      check_for_valid_filepath if (@repository.parameters[:file])
    end

    # private method to the specified parameter constraints
    def check_parameter_constraints
      # check for mandatory date
      raise ArgumentError, "Error: Parameter date is not set" if (!@repository.parameters[:date])
    end

  end

end
