#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-23 16:57:26
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-01-24 08:59:26

require "spec_helper"
require "ruby_utils/statistic"
require "wrf_forecast/threshold"
require "wrf_forecast/text"

describe WrfForecast::Text::WindText do

  describe ".new" do
    context "given an array of wind data for a normal day" do
      it "generate and check wind forecast text" do
        windspeed_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                              1,  1,  1,  1,  2,  2,  2,  2,  3,  3,
                              4,  5,  7,  7,  9,  9,  9,  9,  9,  9, 
                              9,  9,  9,  9,  8,  8,  8,  7,  8,  6,
                              5,  5,  4,  3,  4,  4,  3,  2,  1,  0 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        extreme_values = RubyUtils::ExtremeValues.new(0,  9)
        forecast = WrfForecast::Text::WindText.new(extreme_values, nil, indicators.indicators)
        expected = "The wind will be normal and will reach up to "
        expected.concat("33 km/h from circulatory directions. The mean wind will be 17 km/h.")
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a windy day" do
      it "generate and check wind forecast text" do
        windspeed_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                              1,  1,  1,  1,  2,  2,  2,  2,  3,  3,
                              4,  5,  7,  7,  9,  9, 11, 11, 11, 11, 
                             10, 10,  9,  9,  8,  8,  8,  7,  8,  6,
                              5,  5,  4,  3,  4,  4,  3,  2,  1,  0 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 11)
        forecast = WrfForecast::Text::WindText.new(extreme_values, nil, indicators.indicators)
        expected = "The wind will be windy and will reach up to "
        expected.concat("40 km/h from circulatory directions. The mean wind will be 20 km/h.")
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
        forecast = WrfForecast::Text::WindText.new(extreme_values, :E, indicators.indicators)
        expected = "The wind will be squall and will reach up to "
        expected.concat("72 km/h from east. The mean wind will be 36 km/h.")
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
        forecast = WrfForecast::Text::WindText.new(extreme_values, :W, indicators.indicators)
        expected = "The wind will be stormy and will reach up to "
        expected.concat("94 km/h from west. The mean wind will be 51 km/h.")
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
        forecast = WrfForecast::Text::WindText.new(extreme_values, :SW, indicators.indicators)
        expected = "The wind will be very stromy and will reach up to "
        expected.concat("105 km/h from southwest. The mean wind will be 56 km/h.")
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
                             29, 30, 33.2, 29, 29, 27, 24, 19, 18, 20,
                             18, 16, 14, 12, 14, 15, 12, 15, 14, 12 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        extreme_values = RubyUtils::ExtremeValues.new(2, 33.2)
        forecast = WrfForecast::Text::WindText.new(extreme_values, :NE, indicators.indicators)
        expected = "The wind will be extremly stromy and will reach up to "
        expected.concat("120 km/h from northeast. The mean wind will be 64 km/h.")
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a normal day" do
      it "generate and check wind warning text" do
        windspeed_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                              1,  1,  1,  1,  2,  2,  2,  2,  3,  3,
                              4,  5,  7,  7,  9,  9,  9,  9,  9,  9, 
                              9,  9,  9,  9,  8,  8,  8,  7,  8,  6,
                              5,  5,  4,  3,  4,  4,  3,  2,  1,  0 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 9)
        forecast = WrfForecast::Text::WindText.new(extreme_values, nil, indicators.indicators)
        expect(forecast.warnings).to be_empty
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a windy day" do
      it "generate and check wind warning text" do
        windspeed_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                              1,  1,  1,  1,  2,  2,  2,  2,  3,  3,
                              4,  5,  7,  7,  9,  9, 11, 11, 11, 11, 
                             10, 10,  9,  9,  8,  8,  8,  7,  8,  6,
                              5,  5,  4,  3,  4,  4,  3,  2,  1,  0 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 11)
        forecast = WrfForecast::Text::WindText.new(extreme_values, nil, indicators.indicators)
        expected = "windy day (wind speed exceeds 9 m/s, 33 km/h, 5 bft)"
        expect(forecast.warnings).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a squall day" do
      it "generate and check wind warning text" do
        windspeed_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                              1,  1,  1,  1,  2,  2,  2,  2,  3,  3,
                              4,  5,  7,  7,  9,  9, 11, 11, 11, 11, 
                             12, 12, 14, 16, 13, 17, 14, 17, 18, 20,
                             18, 16, 14, 12, 10,  8,  6,  5,  5,  5 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 20)
        forecast = WrfForecast::Text::WindText.new(extreme_values, :E, indicators.indicators)
        expected = "squall day (wind speed exceeds 14 m/s, 51 km/h, 7 bft)"
        expect(forecast.warnings).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a storm squall day" do
      it "generate and check wind warning text" do
        windspeed_values = [  2,  2,  2,  2,  2,  2,  4,  4,  4,  4, 
                              8,  9,  8,  7, 10, 12, 12, 11, 13, 13,
                             14, 15, 17, 17, 19, 19, 21, 21, 21, 21, 
                             22, 22, 24, 26, 23, 27, 24, 19, 18, 20,
                             18, 16, 14, 12, 10,  8,  6,  5,  5,  5 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        extreme_values = RubyUtils::ExtremeValues.new(2, 26)
        forecast = WrfForecast::Text::WindText.new(extreme_values, :W, indicators.indicators)
        expected = "storm squall day (wind speed exceeds 24 m/s, 87 km/h, 9 bft)"
        expect(forecast.warnings).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a storm day" do
      it "generate and check wind warning text" do
        windspeed_values = [  2,  2,  2,  2,  2,  2,  4,  4,  4,  4, 
                              8,  9,  8,  7, 10, 12, 12, 11, 13, 13,
                             14, 15, 17, 17, 19, 19, 21, 21, 21, 21, 
                             22, 24, 27, 29, 29, 27, 24, 19, 18, 20,
                             18, 16, 14, 12, 10,  8,  6,  5,  5,  5 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        extreme_values = RubyUtils::ExtremeValues.new(2, 29)
        forecast = WrfForecast::Text::WindText.new(extreme_values, :SW, indicators.indicators)
        expected = "storm day (wind speed exceeds 28 m/s, 101 km/h, 10 bft)"
        expect(forecast.warnings).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a hurricane day" do
      it "generate and check wind warning text" do
        windspeed_values = [  2,  2,  2,  2,  2,  2,  4,  4,  4,  4, 
                              8,  9,  8,  7, 10, 12, 12, 11, 13, 13,
                             14, 15, 17, 17, 21, 23, 26, 25, 26, 28, 
                             29, 30, 33.2, 29, 29, 27, 24, 19, 18, 20,
                             18, 16, 14, 12, 14, 15, 12, 15, 14, 12 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        extreme_values = RubyUtils::ExtremeValues.new(2, 33.2)
        forecast = WrfForecast::Text::WindText.new(extreme_values, :NE, indicators.indicators)
        expected = "hurricane day (wind speed exceeds 33 m/s, 119 km/h, 11 bft)"
        expect(forecast.warnings).to eq(expected)
      end
    end
  end

end
