#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-24 16:47:58
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-25 15:28:29

require 'spec_helper'
require 'ruby_utils/statistic'
require_relative '../../lib/threshold'
require_relative '../../lib/data/forecast_repository'
require_relative '../../lib/forecast/english/rain/rain_text'

describe RainText do

  describe ".new" do
    context "given an array of rain data for a normal day" do
      it "generate and check rain forecast text" do
        rain_values = [  0,  1,  1,  2,  2,  1,  1,  0,  0,  0, 
                         0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  0,  0,  0 ]
        indicators = Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 2)
        text = RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = 'The forecast does predict normal rain with a maximum of '
        expected.concat('2 mm in 1 hour and some dry periods.')
        expect(text.forecast_text).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with strong rain" do
      it "generate and check rain forecast text" do
        rain_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  1, 16,  1,  0,  0,  0, 10,  5,  0, 
                         0,  0,  0,  0 ]
        indicators = Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 16)
        text = RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = 'The forecast does predict strong rain with a maximum of '
        expected.concat('16 mm in 1 hour and some dry periods during the day.')
        expect(text.forecast_text).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with heavy rain" do
      it "generate and check rain forecast text" do
        rain_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  1, 26,  1,  0,  0,  0,  0,  5,  0, 
                         0,  0,  0,  0 ]
        indicators = Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 26)
        text = RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = 'The forecast does predict heavy rain with a maximum of '
        expected.concat('26 mm in 1 hour and some dry periods during the day.')
        expect(text.forecast_text).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with extreme rain" do
      it "generate and check rain forecast text" do
        rain_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  1, 41,  1,  0,  0,  0,  0,  0,  0, 
                         0,  0,  0,  0 ]
        indicators = Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 41)
        text = RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = 'The forecast does predict extreme rain with a maximum of '
        expected.concat('41 mm in 1 hour and some dry periods during the day.')
        expect(text.forecast_text).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with extreme rain" do
      it "generate and check rain forecast text" do
        rain_values = [  2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 
                         2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 
                         1,  1,  1,  1 ]
        indicators = Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(1, 2)
        text = RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = 'The forecast does predict continous rain with a maximum of '
        expected.concat('44 mm in 24 hours and no dry periods during the day.')
        expect(text.forecast_text).to match(expected)
      end
    end
  end

end
