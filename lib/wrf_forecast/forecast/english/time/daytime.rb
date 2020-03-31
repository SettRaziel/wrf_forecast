#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-02-18 17:21:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-31 16:27:01

module WrfForecast

  # As part of the forecast text this module holds string replacements 
  # for the considered daytime
  module Daytime
    MORNING = 'morning'
    NOON = 'noon'
    AFTERNOON = 'afternoon'
    EVENING = 'evening'
    NIGHT = 'night'
  end

end
