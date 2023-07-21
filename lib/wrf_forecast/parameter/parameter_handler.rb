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
        check_occurrence(:offset, :period) if (@repository.parameters[:offset])
        check_occurrence(:aggregate, :json) if (@repository.parameters[:aggregate])
      end

      # private method to the specified parameter constraints
      def check_parameter_constraints
        # check mandatory date parameter
        check_mandatory_parameter(:date)

        # check mandatory file parameter
        check_mandatory_parameter(:file)

        # set default value for period if not set
        @repository.parameters[:period] = "24" if (@repository.parameters[:period] == nil)
      end

    end

  end

end
