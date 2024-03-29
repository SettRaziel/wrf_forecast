module WrfForecast

  # This module holds all classes that specify forecast texts and warnings for a given measurand
  module Text

    # This abstract class serves as the prarent class to measurand specific forecast texts. It contains the
    # resulting forecast text for the measurand based on the input data and the warnings specified in the
    # corresponding threshold class.
    class MeasurandText

      # @return [String] the forecast text for the measurand
      attr_reader :text
      # @return [String] the warning text for the measurand
      attr_reader :warnings

      # initialization
      # @param [ExtremeValues] extreme_values the measurand extreme values
      # @param [BaseThreshold] thresholds the measurand threshold
      def initialize(extreme_values, thresholds)
        @extreme_values = extreme_values
        @thresholds = thresholds
        @text = ""
        @warnings = ""
        generate_forecast_text
        generate_warning_text
      end

      private

      # @return [ExtremeValues] the measurand extreme values
      attr_reader :extreme_values
      # @return [TemperatureThreshold] the measurand thresholds
      attr_reader :thresholds

      # method to determine if the threshold for the given indicator is active
      # @param [Symbol] indicator the given threshold indicator
      # @return boolean if the thresolhd to the indicator is active
      def is_threshold_active?(indicator)
        if (@thresholds[indicator].is_active)
          @warnings = @thresholds[indicator].warning_text
        end
        @thresholds[indicator].is_active
      end

      # abstract method to generate the forecast text for the measurand
      # @raise [NotImplementedError] if the child class does not implement this
      def generate_forecast_text
        fail NotImplementedError, " Error: the subclass #{self.class} needs " \
             "to implement the method: generate_forecast_text from its base class".red
      end

      # abstract method to generate the warning text for the measurand
      # @raise [NotImplementedError] if the child class does not implement this
      def generate_warning_text
        fail NotImplementedError, " Error: the subclass #{self.class} needs " \
             "to implement the method: generate_warning_text from its base class".red
      end

    end

  end

end
