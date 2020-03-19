#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-19 14:02:55
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-19 17:37:08

require 'ruby_utils/string'

module Threshold

  # This abstract class determines the significant thresholds for a forecast day.
  # That means that this class can only work correctly if the data represents a time
  # span of up to 24 hours.
  # Will raise an NotImplementedError if the abstract methods are called without 
  # an implementation in a child class
  class BaseThreshold

    # @return [Hash] the indicator by mapping symbol => boolean
    attr_reader :indicators

    # initialization
    # @param [Array] data_values the input values
    def initialize(data_values)
      @indicators = Hash.new()
      initialize_indicators
      check_data_values(data_values)
      determine_indicators(data_values)
    end

    private

    # method to check if the data sample offers enough data for the indicators
    # less than 720 data points means, less than 1 data point every 2 minutes
    # less then 48 data points means, less than 2 data points per hours
    # @raise [ArgumentError] if the data values are not sufficient
    def check_data_values(data_values)
      if (data_values.size < 720)
        puts "Warning: Data values for #{self.class} are lesser than 720."
      end
      if (data_values.size < 48)
        raise ArgumentError, "Error: Lesser than 48 data values available for threshold."
      end
    end

    # abstract method to initialize of the required indicators
    # @raise [NotImplementedError] if the child class does not implement this
    def initialize_indicators
      fail NotImplementedError, " Error: the subclass #{self.class} needs " \
       "to implement the method: initialize_indicators from its base class".red
    end

    # abstract method to determine the indicators based on the input data
    # @param [Array] data_values the input values
    # @raise [NotImplementedError] if the child class does not implement this
    def determine_indicators(data_values)
      fail NotImplementedError, " Error: the subclass #{self.class} needs " \
       "to implement the method: determine_indicators from its base class".red      
    end

  end

end
