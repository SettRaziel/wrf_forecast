require "spec_helper"
require "ruby_utils/statistic"
require "wrf_forecast/threshold"
require "wrf_forecast/text"

describe WrfForecast::Text::ApparentTemperatureText do

  describe ".new" do
    context "given an array of apparent temperature data for a summer day" do
      it "generate and check temperature forecast text" do
        temperature_values = [ 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
                               29, 29, 29, 29, 29, 29, 29, 29, 29, 29,
                               31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
                               23, 23, 23, 23, 23, 23, 23, 23, 23, 23,
                               25, 25, 25, 25, 25, 25, 25, 25, 25, 25
                             ]
        indicators = WrfForecast::Threshold::ApparentTemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(23, 31)
        forecast = WrfForecast::Text::ApparentTemperatureText.new(extreme_values, indicators.indicators)
        expected = I18n.t("forecast_text.apparent_temperature.text_start")
        expected.concat(I18n.t("forecast_text.apparent_temperature.feeling_normal"))
        expected.concat(I18n.t("forecast_text.apparent_temperature.text_maximum")).concat("31")
        expected.concat(I18n.t("forecast_text.apparent_temperature.text_minimum")).concat("23")
        expected.concat(I18n.t("forecast_text.apparent_temperature.text_finish"))
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of apparent temperature data for a strong heat day" do
      it "generate and check temperature forecast text" do
        temperature_values = [ 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
                               29, 29, 29, 29, 29, 29, 29, 29, 29, 29,
                               31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
                               33, 33, 33, 33, 33, 33, 33, 33, 33, 33,
                               35, 35, 35, 35, 35, 35, 35, 35, 35, 35
                             ]
        indicators = WrfForecast::Threshold::ApparentTemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(27, 35)
        forecast = WrfForecast::Text::ApparentTemperatureText.new(extreme_values, indicators.indicators)
        expected = I18n.t("forecast_text.apparent_temperature.text_start")
        expected.concat(I18n.t("forecast_text.apparent_temperature.feeling_strong_heat"))
        expected.concat(I18n.t("forecast_text.apparent_temperature.text_maximum")).concat("35")
        expected.concat(I18n.t("forecast_text.apparent_temperature.text_minimum")).concat("27")
        expected.concat(I18n.t("forecast_text.apparent_temperature.text_finish"))      
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of apparent temperature data for an extreme heat day" do
      it "generate and check temperature forecast text" do
        temperature_values = [ 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
                               29, 29, 29, 29, 29, 29, 29, 29, 29, 29,
                               31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
                               33, 33, 33, 33, 33, 33, 33, 33, 33, 33,
                               35, 35, 35, 35, 39, 39, 35, 35, 35, 35
                             ]
        indicators = WrfForecast::Threshold::ApparentTemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(27, 39)
        forecast = WrfForecast::Text::ApparentTemperatureText.new(extreme_values, indicators.indicators)
        expected = I18n.t("forecast_text.apparent_temperature.text_start")
        expected.concat(I18n.t("forecast_text.apparent_temperature.feeling_extreme_heat"))
        expected.concat(I18n.t("forecast_text.apparent_temperature.text_maximum")).concat("39")
        expected.concat(I18n.t("forecast_text.apparent_temperature.text_minimum")).concat("27")
        expected.concat(I18n.t("forecast_text.apparent_temperature.text_finish"))
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of apparent temperature data for a spring day" do
      it "generate and check temperature forecast text" do
        temperature_values = [ 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
                               29, 29, 29, 29, 29, 29, 29, 29, 29, 29,
                               31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
                               23, 23, 23, 23, 23, 23, 23, 23, 23, 23,
                               25, 25, 25, 25, 25, 25, 25, 25, 25, 25
                             ]
        indicators = WrfForecast::Threshold::ApparentTemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(23, 31)
        forecast = WrfForecast::Text::ApparentTemperatureText.new(extreme_values, indicators.indicators)
        expect(forecast.warnings).to be_empty
      end
    end
  end

  describe ".new" do
    context "given an array of apparent temperature data for a summer day" do
      it "generate and check temperature forecast text" do
        temperature_values = [ 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
                               29, 29, 29, 29, 29, 29, 29, 29, 29, 29,
                               31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
                               33, 33, 33, 33, 33, 33, 33, 33, 33, 33,
                               35, 35, 35, 35, 35, 35, 35, 35, 35, 35
                             ]
        indicators = WrfForecast::Threshold::ApparentTemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(27, 35)
        forecast = WrfForecast::Text::ApparentTemperatureText.new(extreme_values, indicators.indicators)
        expect(forecast.warnings).to eq(I18n.t("threshold.apparent_temperature.strong_heat_day"))
      end
    end
  end

  describe ".new" do
    context "given an array of apparent temperature data for a hot day with tropical night" do
      it "generate and check temperature forecast text" do
        temperature_values = [ 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
                               29, 29, 29, 29, 29, 29, 29, 29, 29, 29,
                               31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
                               33, 33, 33, 33, 33, 33, 33, 33, 33, 33,
                               35, 35, 35, 35, 39, 39, 35, 35, 35, 35
                             ]
        indicators = WrfForecast::Threshold::ApparentTemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(27, 39)
        forecast = WrfForecast::Text::ApparentTemperatureText.new(extreme_values, indicators.indicators)
        expect(forecast.warnings).to eq(I18n.t("threshold.apparent_temperature.extreme_heat_day"))
      end
    end
  end

end
