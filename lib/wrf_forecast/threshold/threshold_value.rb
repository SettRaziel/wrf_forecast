module WrfForecast

  module Threshold

    # A simple data class that stores information for a given threshold
    class ThresholdValue

      # @return [Symbol] the symbol that identifies the threshold
      attr_reader :identifier
      # @return [boolean] a bool flag that indicated if the threshold was activated
      attr_accessor :is_active
      # @return [String] the corresponding warning text to the threshold
      attr_reader :warning_text

      # initialization
      # @param [Symbol] identifier the symbol that identifies the threshold
      # @param [boolean] is_active a bool flag that indicated if the threshold was activated
      # @param [String] warning_text the corresponding warning text to the threshold
      def initialize(identifier, is_active, warning_text)
        @identifier = identifier
        @is_active = is_active
        @warning_text = warning_text
      end

    end
    
  end

end
