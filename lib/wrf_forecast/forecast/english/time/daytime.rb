#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-02-18 17:21:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-10 08:34:46

module WrfForecast

  # As part of the forecast text this module holds string replacements 
  # for the considered daytime
  # @todo not used at the moment
  module Daytime
    # @return [String] string representation for the morning
    MORNING = 'morning'
    # @return [String] string representation for the noon
    NOON = 'noon'
    # @return [String] string representation for the afternoon
    AFTERNOON = 'afternoon'
    # @return [String] string representation for the evening    
    EVENING = 'evening'
    # @return [String] string representation for the night
    NIGHT = 'night'
  end

end
