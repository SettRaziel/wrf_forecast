#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-12 19:05:50
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-12 19:50:30

class WindDirectionRepository

  def initialize
    @directions = Hash.new()
    @directions[:NE] = WindDirection.new( 22.5,  67.5, :NE)
    @directions[:E]  = WindDirection.new( 67.5, 112.5, :E)
    @directions[:SE] = WindDirection.new(112.5, 157.5, :SE)
    @directions[:S]  = WindDirection.new(157.5, 202.5, :S)
    @directions[:SW] = WindDirection.new(202.5, 247.5, :SW)
    @directions[:W]  = WindDirection.new(247.5, 292.5, :W)
    @directions[:NW] = WindDirection.new(292.5, 337.5, :NW)
  end

  def determine_wind_sector(value)
    @directions.each_value { |direction|
      if (value > direction.lower && value <= direction.upper)
        return direction.symbol
      elsif ((value > 337.5 && value <= 360.0) || 
              (value <= 22.5 && value >= 0.0))
        return :N
      end
    }
    raise ArgumentError, "Given value #{value} does not represent a wind direction"
  end

  private

  attr_reader :directions
end

class WindDirection

  attr_reader :lower
  attr_reader :upper
  attr_reader :symbol

  def initialize(lower, upper, symbol)
    @lower = lower
    @upper = upper
    @symbol = symbol
  end

end
