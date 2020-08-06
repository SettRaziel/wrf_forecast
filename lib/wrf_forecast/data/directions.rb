#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-08-06 19:24:10
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-08-06 19:56:01

module WrfForecast

  class Directions

    def initialize
      initialize_directions
    end

    def get_direction_string(symbol)
      @directions[symbol]
    end
  
    private

    # @return [Hash] the mapping of direction and direction name
    attr_reader :directions

    # method to initialize the mapping from direction to direction text
    def initialize_directions
      @directions = Hash.new()
      @directions[:N]  = "north"
      @directions[:S]  = "south"
      @directions[:W]  = "west"
      @directions[:E]  = "east"
      @directions[:NW] = "northwest"
      @directions[:NE] = "northeast"
      @directions[:SW] = "southwest"
      @directions[:SE] = "southeast"
      nil
    end
  end

end
