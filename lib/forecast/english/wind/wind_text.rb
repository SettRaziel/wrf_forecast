#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-23 16:27:56
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-24 16:30:49

# This class generates the forecast text for the wind speed
# and direction of the forecast
class WindText

  # @return [String] the forecast text for the wind forecast
  attr_reader :forecast_text

  # initialization
  # @param [ExtremeValues] extreme_values the wind extreme values
  # @param [Symbol] prevalent_direction the prevalent wind direction
  # @param [WindThreshold] thresholds the wind threshold
  def initialize(extreme_values, prevalent_direction, thresholds)
    @extreme_values = extreme_values
    @thresholds = thresholds
    @prevalent_direction = prevalent_direction
    initialize_directions
    generate_wind_text
  end

  private

  # @return [ExtremeValues] the wind extreme values
  attr_reader :extreme_values
  # @return [WindThreshold] the wind thresholds
  attr_reader :thresholds
  # @return [Symbol] the prevalent wind direction
  attr_reader :prevalent_direction
  # @return [Hash] the mapping of direction and direction name
  attr_reader :directions

  # method to initialize the mapping from direction to direction text
  def initialize_directions
    @directions = Hash.new()
    @directions[:N]  = 'north'
    @directions[:S]  = 'south'
    @directions[:W]  = 'west'
    @directions[:E]  = 'east'
    @directions[:NW] = 'northwest'
    @directions[:NE] = 'northeast'
    @directions[:SW] = 'southwest'
    @directions[:SE] = 'southeast'
    nil
  end

  # method to generate the forecast text for the wind
  def generate_wind_text
    @forecast_text = 'The wind will be '
    @forecast_text.concat(create_strength_text)
    @forecast_text.concat(create_wind_text)
    nil
  end

  # method to generate the text about the day
  def create_strength_text
    wind_strength = 'normal'
    wind_strength = 'squall' if (@thresholds[:squall_day])
    wind_strength = 'stormy' if (@thresholds[:storm_squall_day])
    wind_strength = 'very stromy' if (@thresholds[:storm_day])
    wind_strength = 'extremly stromy' if (@thresholds[:hurricane_day])
    return wind_strength
  end

  # method to generate the text with wind values
  def create_wind_text
    text = ' and will reach up to '
    text.concat((@extreme_values.maximum * 3.6).ceil.to_s)
    text.concat(' km/h from ')
    text.concat(create_prevalent_direction_text)
    text.concat('. The mean wind will be ')
    mean = (@extreme_values.maximum + @extreme_values.minimum) / 2.0
    text.concat((mean * 3.6).ceil.to_s)
    text.concat(' km/h.')
    return text
  end

  # method to create the text for the prevalent wind direction
  def create_prevalent_direction_text
    if (@prevalent_direction == nil)
      return 'circulatory directions'
    end
    return @directions[@prevalent_direction]
  end

end
