#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-23 16:57:26
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-21 19:31:54

require 'spec_helper'
require 'ruby_utils/statistic'
require 'wrf_forecast/threshold'
require 'wrf_forecast/forecast/english/wind/wind_text'

describe WrfForecast::WindText do

  describe ".new" do
    context "given an array of wind data for a normal day" do
      it "generate and check wind forecast text" do
        windspeed_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                              1,  1,  1,  1,  2,  2,  2,  2,  3,  3,
                              4,  5,  7,  7,  9,  9, 11, 11, 11, 11, 
                             10, 10,  9,  9,  8,  8,  8,  7,  8,  6,
                              5,  5,  4,  3,  4,  4,  3,  2,  1,  0 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 11)
        forecast = WrfForecast::WindText.new(extreme_values, nil, indicators.indicators)
        expected = 'The wind will be normal and will reach up to '
        expected.concat('40 km/h from circulatory directions. The mean wind will be 20 km/h.')
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a squall day" do
      it "generate and check wind forecast text" do
        windspeed_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                              1,  1,  1,  1,  2,  2,  2,  2,  3,  3,
                              4,  5,  7,  7,  9,  9, 11, 11, 11, 11, 
                             12, 12, 14, 16, 13, 17, 14, 17, 18, 20,
                             18, 16, 14, 12, 10,  8,  6,  5,  5,  5 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 20)
        forecast = WrfForecast::WindText.new(extreme_values, :E, indicators.indicators)
        expected = 'The wind will be squall and will reach up to '
        expected.concat('72 km/h from east. The mean wind will be 36 km/h.')
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a storm squall day" do
      it "generate and check wind forecast text" do
        windspeed_values = [  2,  2,  2,  2,  2,  2,  4,  4,  4,  4, 
                              8,  9,  8,  7, 10, 12, 12, 11, 13, 13,
                             14, 15, 17, 17, 19, 19, 21, 21, 21, 21, 
                             22, 22, 24, 26, 23, 27, 24, 19, 18, 20,
                             18, 16, 14, 12, 10,  8,  6,  5,  5,  5 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        extreme_values = RubyUtils::ExtremeValues.new(2, 26)
        forecast = WrfForecast::WindText.new(extreme_values, :W, indicators.indicators)
        expected = 'The wind will be stormy and will reach up to '
        expected.concat('94 km/h from west. The mean wind will be 51 km/h.')
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a storm day" do
      it "generate and check wind forecast text" do
        windspeed_values = [  2,  2,  2,  2,  2,  2,  4,  4,  4,  4, 
                              8,  9,  8,  7, 10, 12, 12, 11, 13, 13,
                             14, 15, 17, 17, 19, 19, 21, 21, 21, 21, 
                             22, 24, 27, 29, 29, 27, 24, 19, 18, 20,
                             18, 16, 14, 12, 10,  8,  6,  5,  5,  5 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        extreme_values = RubyUtils::ExtremeValues.new(2, 29)
        forecast = WrfForecast::WindText.new(extreme_values, :SW, indicators.indicators)
        expected = 'The wind will be very stromy and will reach up to '
        expected.concat('105 km/h from southwest. The mean wind will be 56 km/h.')
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a hurricane day" do
      it "generate and check wind forecast text" do
        windspeed_values = [  2,  2,  2,  2,  2,  2,  4,  4,  4,  4, 
                              8,  9,  8,  7, 10, 12, 12, 11, 13, 13,
                             14, 15, 17, 17, 21, 23, 26, 25, 26, 28, 
                             29, 30, 33, 29, 29, 27, 24, 19, 18, 20,
                             18, 16, 14, 12, 14, 15, 12, 15, 14, 12 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        extreme_values = RubyUtils::ExtremeValues.new(2, 33)
        forecast = WrfForecast::WindText.new(extreme_values, :NE, indicators.indicators)
        expected = 'The wind will be extremly stromy and will reach up to '
        expected.concat('119 km/h from northeast. The mean wind will be 63 km/h.')
        expect(forecast.text).to eq(expected)
      end
    end
  end

end
