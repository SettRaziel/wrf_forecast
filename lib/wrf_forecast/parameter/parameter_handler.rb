# @Author: Benjamin Held
# @Date:   2015-07-20 11:23:58
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-13 13:57:05

module WrfForecast

  module Parameter

    # class to seperate the storage of the parameter in a repository entity and
    # checking for valid parameter combination as part of the application logic.
    class ParameterHandler < RubyUtils::Parameter::BaseParameterHandler

      # method to initialize the correct repository that should be used 
      # in this handler
      # @param [Array] argv array of input parameters
      def initialize_repository(argv)
        @repository = WrfForecast::Parameter::ParameterRepository.new(argv)
      end

      private

      # private method with calls of the different validations methods
      def validate_parameters
        check_for_valid_filepath if (@repository.parameters[:file])
        check_occurrence(:offset, :period) if (@repository.parameters[:offset])
      end

      # private method to the specified parameter constraints
      def check_parameter_constraints
        # check for mandatory date when help or version is not used
        if (!@repository.parameters[:date] &&
            !(@repository.parameters[:help] || @repository.parameters[:version]))
          raise ArgumentError, "Error: Parameter date is not set" 
        end
      end

    end

  end

end
