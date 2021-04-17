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
        expected = I18n.t("forecast_text.wind.text_start")
        expected.concat(I18n.t("forecast_text.wind.strength_normal"))
        expected.concat(I18n.t("forecast_text.wind.text_maximum")).concat("33")
        expected.concat(I18n.t("forecast_text.wind.text_maximum_unit"))
        expected.concat(I18n.t("forecast_text.wind.direction_circular"))
        expected.concat(I18n.t("forecast_text.wind.text_mean")).concat("17")
        expected.concat(I18n.t("forecast_text.wind.text_finish"))
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
        expected = I18n.t("forecast_text.wind.text_start")
        expected.concat(I18n.t("forecast_text.wind.strength_windy"))
        expected.concat(I18n.t("forecast_text.wind.text_maximum")).concat("40")
        expected.concat(I18n.t("forecast_text.wind.text_maximum_unit"))
        expected.concat(I18n.t("forecast_text.wind.direction_circular"))
        expected.concat(I18n.t("forecast_text.wind.text_mean")).concat("20")
        expected.concat(I18n.t("forecast_text.wind.text_finish"))
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
        expected = I18n.t("forecast_text.wind.text_start")
        expected.concat(I18n.t("forecast_text.wind.strength_squall"))
        expected.concat(I18n.t("forecast_text.wind.text_maximum")).concat("72")
        expected.concat(I18n.t("forecast_text.wind.text_maximum_unit"))
        expected.concat(I18n.t("direction.east"))
        expected.concat(I18n.t("forecast_text.wind.text_mean")).concat("36")
        expected.concat(I18n.t("forecast_text.wind.text_finish"))
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
        expected = I18n.t("forecast_text.wind.text_start")
        expected.concat(I18n.t("forecast_text.wind.strength_stormy"))
        expected.concat(I18n.t("forecast_text.wind.text_maximum")).concat("94")
        expected.concat(I18n.t("forecast_text.wind.text_maximum_unit"))
        expected.concat(I18n.t("direction.west"))
        expected.concat(I18n.t("forecast_text.wind.text_mean")).concat("51")
        expected.concat(I18n.t("forecast_text.wind.text_finish"))
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
        expected = I18n.t("forecast_text.wind.text_start")
        expected.concat(I18n.t("forecast_text.wind.strength_very_stormy"))
        expected.concat(I18n.t("forecast_text.wind.text_maximum")).concat("105")
        expected.concat(I18n.t("forecast_text.wind.text_maximum_unit"))
        expected.concat(I18n.t("direction.southwest"))
        expected.concat(I18n.t("forecast_text.wind.text_mean")).concat("56")
        expected.concat(I18n.t("forecast_text.wind.text_finish"))
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
        expected = I18n.t("forecast_text.wind.text_start")
        expected.concat(I18n.t("forecast_text.wind.strength_extremly_stormy"))
        expected.concat(I18n.t("forecast_text.wind.text_maximum")).concat("120")
        expected.concat(I18n.t("forecast_text.wind.text_maximum_unit"))
        expected.concat(I18n.t("direction.northeast"))
        expected.concat(I18n.t("forecast_text.wind.text_mean")).concat("64")
        expected.concat(I18n.t("forecast_text.wind.text_finish"))
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
        expect(forecast.warnings).to eq(I18n.t("threshold.wind.windy_day"))
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
        expect(forecast.warnings).to eq(I18n.t("threshold.wind.squall_day"))
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
        expect(forecast.warnings).to eq(I18n.t("threshold.wind.storm_squall_day"))
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
        expect(forecast.warnings).to eq(I18n.t("threshold.wind.storm_day"))
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
        expect(forecast.warnings).to eq(I18n.t("threshold.wind.hurricane_day"))
      end
    end
  end

end
