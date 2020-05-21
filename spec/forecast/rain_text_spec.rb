#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-24 16:47:58
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-05-19 17:47:40

require "spec_helper"
require "ruby_utils/statistic"
require "wrf_forecast/threshold"
require "wrf_forecast/text"

describe WrfForecast::Text::RainText do

  describe ".new" do
    context "given an array of rain data for a normal day" do
      it "generate and check rain forecast text" do
        rain_values = [  0,  1,  1,  2,  2,  1,  1,  0,  0,  0, 
                         0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  0,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 2)
        forecast = WrfForecast::Text::RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = "The forecast does predict normal rain with a maximum of "
        expected.concat("2 mm in 1 hour and up to 8 mm for the day.")
        expected.concat(" There are some dry periods during the day.")
        expect(forecast.text).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with strong rain" do
      it "generate and check rain forecast text" do
        rain_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  1, 16,  1,  0,  0,  0, 10,  5,  0, 
                         0,  0,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 16)
        forecast = WrfForecast::Text::RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = "The forecast does predict strong rain with a maximum of "
        expected.concat("16 mm in 1 hour and up to 33 mm for the day.")
        expected.concat(" There are some dry periods during the day.")
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with heavy rain" do
      it "generate and check rain forecast text" do
        rain_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  1, 26,  1,  0,  0,  0,  0,  5,  0, 
                         0,  0,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 26)
        forecast = WrfForecast::Text::RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = "The forecast does predict heavy rain with a maximum of "
        expected.concat("26 mm in 1 hour and up to 33 mm for the day.")
        expected.concat(" There are some dry periods during the day.")       
        expect(forecast.text).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with extreme rain" do
      it "generate and check rain forecast text" do
        rain_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  1, 41,  1,  0,  0,  0,  0,  0,  0, 
                         0,  0,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 41)
        forecast = WrfForecast::Text::RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = "The forecast does predict extreme rain with a maximum of "
        expected.concat("41 mm in 1 hour and up to 43 mm for the day.")
        expected.concat(" There are some dry periods during the day.")        
        expect(forecast.text).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with continous rain" do
      it "generate and check rain forecast text" do
        rain_values = [  2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 
                         2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 
                         1,  1,  1,  1 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(1, 2)
        forecast = WrfForecast::Text::RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = "The forecast does predict continous rain with a maximum of "
        expected.concat("44 mm in 24 hours. There are no dry periods during the day.")
        expect(forecast.text).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a normal day" do
      it "generate and check rain forecast warnings" do
        rain_values = [  0,  1,  1,  2,  2,  1,  1,  0,  0,  0, 
                         0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  0,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 2)
        forecast = WrfForecast::Text::RainText.new(extreme_values, rain_values, indicators.indicators)
        expect(forecast.warnings).to be_empty
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with strong rain" do
      it "generate and check rain forecast warnings" do
        rain_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  1, 16,  1,  0,  0,  0, 10,  5,  0, 
                         0,  0,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 16)
        forecast = WrfForecast::Text::RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = "strong rain (hourly rain sum exceeds 15 mm per hour)"
        expect(forecast.warnings).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with heavy rain" do
      it "generate and check rain forecast warnings" do
        rain_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  1, 26,  1,  0,  0,  0,  0,  5,  0, 
                         0,  0,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 26)
        forecast = WrfForecast::Text::RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = "heavy rain (hourly rain sum exceeds 25 mm per hour)"
        expect(forecast.warnings).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with extreme rain" do
      it "generate and check rain forecast warnings" do
        rain_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  1, 41,  1,  0,  0,  0,  0,  0,  0, 
                         0,  0,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 41)
        forecast = WrfForecast::Text::RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = "extreme rain (hourly rain sum exceeds 40 mm per hour)"
        expect(forecast.warnings).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with continous rain" do
      it "generate and check rain forecast warnings" do
        rain_values = [  2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 
                         2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 
                         1,  1,  1,  1 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(1, 2)
        forecast = WrfForecast::Text::RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = "continous rain (rain sum exceeds 30 mm per 24 hours)"
        expect(forecast.warnings).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with strong and continous rain" do
      it "generate and check rain forecast warnings" do
        rain_values = [  2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 
                         2,  2,  16,  2,  2,  2,  2,  2,  2,  2, 
                         1,  1,  1,  1 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(1, 2)
        forecast = WrfForecast::Text::RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = "strong rain (hourly rain sum exceeds 15 mm per hour)"
        expected.concat("\ncontinous rain (rain sum exceeds 30 mm per 24 hours)")
        expect(forecast.warnings).to match(expected)
      end
    end
  end

end
