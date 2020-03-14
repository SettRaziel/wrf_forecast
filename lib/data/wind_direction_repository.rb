#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-12 19:05:50
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-14 12:02:33

# This class serves as the creation and storage component of a wind direction distribution
class WindDirectionRepository

  # @return [Hash] the wind direction distribution once it is calculated or an empty hash
  attr_reader :direction_distribution

  # initialization
  def initialize
    @directions = Hash.new()
    @directions[:NE] = WindDirection.new( 22.5,  67.5, :NE)
    @directions[:E]  = WindDirection.new( 67.5, 112.5, :E)
    @directions[:SE] = WindDirection.new(112.5, 157.5, :SE)
    @directions[:S]  = WindDirection.new(157.5, 202.5, :S)
    @directions[:SW] = WindDirection.new(202.5, 247.5, :SW)
    @directions[:W]  = WindDirection.new(247.5, 292.5, :W)
    @directions[:NW] = WindDirection.new(292.5, 337.5, :NW)
    
    @direction_distribution = Hash.new()
    @direction_distribution[:N] = 0
    @directions.each_key { |key|
      @direction_distribution[key] = 0
    }
  end

  # method to determine the wind section for a given value
  # @params [Float] the wind direction
  # @return [Symbol] the wind direction symbol of the corresponding sector
  # @raise [ArgumentError] if the value lies outside the direction interval [0, 360]
  def determine_wind_sector(value)
    @directions.each_value { |direction|
      if (value > direction.lower && value <= direction.upper)
        return direction.symbol
      elsif ((value > 337.5 && value <= 360.0) || 
              (value <= 22.5 && value >= 0.0))
        return :N
      end
    }
    raise ArgumentError, "Given value #{value} does not represent a wind direction."
  end

  # method to generate a wind direction distribution based on the given input data
  # @return [Hash] the calculated direction distribution
  def generate_direction_distribution(data)
    data.each { |value|
      sector = determine_wind_sector(value)
      @direction_distribution[sector] = @direction_distribution[sector] + 1
    }
    return @direction_distribution
  end    

  private

  # @return [Hash] internal mapping from wind direction symbol to degree interval
  attr_reader :directions

end

# Simple helper class to store the direction interval data
class WindDirection

  # @return [Float] the lower boundary to the direction interval
  attr_reader :lower
  # @return [Float] the upper boundary to the direction interval
  attr_reader :upper
  # @return [Symbol] the description symbol for the interval
  attr_reader :symbol

  # initializaion
  # @params [Float] the lower boundary to the direction interval
  # @params [Float] the upper boundary to the direction interval
  # @params [Symbol] the description symbol for the interval
  def initialize(lower, upper, symbol)
    @lower = lower
    @upper = upper
    @symbol = symbol
  end

end
