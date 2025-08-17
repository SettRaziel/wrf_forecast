require "spec_helper"
require "ruby_utils/statistic"
require "wrf_forecast/threshold"
require "wrf_forecast/text"

describe WrfForecast::Text::PressureText do

  describe ".new" do
    context "given an array of pressure data for a low pressure day" do
      it "generate and check pressure forecast text" do
        pressure_values = [ 101300, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101170, 101160, 101050, 101040, 101030, 100950, 100920,
                            100900, 101290, 101280, 101270, 100860, 101250, 101240, 100730, 100700, 100620,
                            100600, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            100300, 100290, 100280, 100270, 100260, 100250, 101240, 101230, 101220, 101220
                          ]
        indicators = WrfForecast::Threshold::PressureThreshold.new(pressure_values)
        extreme_values = RubyUtils::ExtremeValues.new(100250, 101300)
        pressure_mean = (pressure_values.sum(0.0) / (pressure_values.size * 100)).round(1)
        forecast = WrfForecast::Text::PressureText.new(extreme_values, pressure_values, indicators.indicators)
        expected = I18n.t("forecast_text.pressure.text_start")
        expected.concat(I18n.t("forecast_text.pressure.level_low"))
        expected.concat(I18n.t("forecast_text.pressure.text_with")).concat(pressure_mean.to_s)
        expected.concat(I18n.t("forecast_text.pressure.text_continue"))
        expected.concat(I18n.t("forecast_text.pressure.text_maximum")).concat("1013")
        expected.concat(I18n.t("forecast_text.pressure.text_minimum")).concat("1002")
        expected.concat(I18n.t("forecast_text.pressure.text_finish"))
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of pressure data for a very low pressure day" do
      it "generate and check pressure forecast text" do
        pressure_values = [ 101300, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101170, 101160, 101050, 101040, 101030, 100950, 100920,
                            100900, 101290, 101280, 101270, 100860, 101250, 101240, 100730, 100700, 100620,
                            100600, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            100300, 100290, 100280, 100270, 100260, 100250, 101240, 101230, 101220, 98920
                          ]
        indicators = WrfForecast::Threshold::PressureThreshold.new(pressure_values)
        extreme_values = RubyUtils::ExtremeValues.new(98920, 101300)
        pressure_mean = (pressure_values.sum(0.0) / (pressure_values.size * 100)).round(1)
        forecast = WrfForecast::Text::PressureText.new(extreme_values, pressure_values, indicators.indicators)
        expected = I18n.t("forecast_text.pressure.text_start")
        expected.concat(I18n.t("forecast_text.pressure.level_very_low"))
        expected.concat(I18n.t("forecast_text.pressure.text_with")).concat(pressure_mean.to_s)
        expected.concat(I18n.t("forecast_text.pressure.text_continue"))
        expected.concat(I18n.t("forecast_text.pressure.text_maximum")).concat("1013")
        expected.concat(I18n.t("forecast_text.pressure.text_minimum")).concat("989")
        expected.concat(I18n.t("forecast_text.pressure.text_finish"))
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of pressure data for a very high pressure day" do
      it "generate and check pressure forecast text" do
        pressure_values = [ 103600, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101170, 101160, 101050, 101040, 101030, 100950, 100920,
                            100900, 101290, 101280, 101270, 100860, 101250, 101240, 100730, 100700, 100620,
                            100600, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101200
                          ]
        indicators = WrfForecast::Threshold::PressureThreshold.new(pressure_values)
        extreme_values = RubyUtils::ExtremeValues.new(100600, 103600)
        pressure_mean = (pressure_values.sum(0.0) / (pressure_values.size * 100)).round(1)
        forecast = WrfForecast::Text::PressureText.new(extreme_values, pressure_values, indicators.indicators)
        expected = I18n.t("forecast_text.pressure.text_start")
        expected.concat(I18n.t("forecast_text.pressure.level_very_high"))
        expected.concat(I18n.t("forecast_text.pressure.text_with")).concat(pressure_mean.to_s)
        expected.concat(I18n.t("forecast_text.pressure.text_continue"))
        expected.concat(I18n.t("forecast_text.pressure.text_maximum")).concat("1036")
        expected.concat(I18n.t("forecast_text.pressure.text_minimum")).concat("1006")
        expected.concat(I18n.t("forecast_text.pressure.text_finish"))
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of pressure data for a high pressure day" do
      it "generate and check pressure forecast text" do
        pressure_values = [ 102100, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101170, 101160, 101050, 101040, 101030, 100950, 100920,
                            100900, 101290, 101280, 101270, 100860, 101250, 101240, 100730, 100700, 100620,
                            100600, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101200
                          ]
        indicators = WrfForecast::Threshold::PressureThreshold.new(pressure_values)
        extreme_values = RubyUtils::ExtremeValues.new(100600, 102100)
        pressure_mean = (pressure_values.sum(0.0) / (pressure_values.size * 100)).round(1)
        forecast = WrfForecast::Text::PressureText.new(extreme_values, pressure_values, indicators.indicators)
        expected = I18n.t("forecast_text.pressure.text_start")
        expected.concat(I18n.t("forecast_text.pressure.level_high"))
        expected.concat(I18n.t("forecast_text.pressure.text_with")).concat(pressure_mean.to_s)
        expected.concat(I18n.t("forecast_text.pressure.text_continue"))
        expected.concat(I18n.t("forecast_text.pressure.text_maximum")).concat("1021")
        expected.concat(I18n.t("forecast_text.pressure.text_minimum")).concat("1006")
        expected.concat(I18n.t("forecast_text.pressure.text_finish"))
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of pressure data for a normal pressure day" do
      it "generate and check pressure forecast text" do
        pressure_values = [ 101300, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101170, 101160, 101050, 101040, 101030, 100950, 100920,
                            100900, 101290, 101280, 101270, 100860, 101250, 101240, 100730, 100700, 100620,
                            100600, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101200
                          ]
        indicators = WrfForecast::Threshold::PressureThreshold.new(pressure_values)
        extreme_values = RubyUtils::ExtremeValues.new(100600, 101300)
        pressure_mean = (pressure_values.sum(0.0) / (pressure_values.size * 100)).round(1)
        forecast = WrfForecast::Text::PressureText.new(extreme_values, pressure_values, indicators.indicators)
        expected = I18n.t("forecast_text.pressure.text_start")
        expected.concat(I18n.t("forecast_text.pressure.level_normal"))
        expected.concat(I18n.t("forecast_text.pressure.text_with")).concat(pressure_mean.to_s)
        expected.concat(I18n.t("forecast_text.pressure.text_continue"))
        expected.concat(I18n.t("forecast_text.pressure.text_maximum")).concat("1013")
        expected.concat(I18n.t("forecast_text.pressure.text_minimum")).concat("1006")
        expected.concat(I18n.t("forecast_text.pressure.text_finish"))
        expect(forecast.text).to eq(expected)
      end
    end
  end

end
