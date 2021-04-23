require "spec_helper"
require "ruby_utils/statistic"
require "wrf_forecast/threshold"
require "wrf_forecast/text"

describe WrfForecast::Text::TemperatureText do

  describe ".new" do
    context "given an array of temperature data for an ice day" do
      it "generate and check temperature forecast text" do
        temperature_values = [ 268, 268, 268, 268, 267, 267, 267, 267, 266, 266, 
                               266, 266, 265, 265, 265, 265, 266, 266, 266, 266,
                               267, 267, 268, 268, 269, 269, 270, 270, 271, 271, 
                               271, 271, 272, 272, 271, 271, 271, 270, 270, 270,
                               269, 269, 269, 269, 268, 268, 268, 268, 268, 267
                             ]
        indicators = WrfForecast::Threshold::TemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(265.15, 272.15)
        forecast = WrfForecast::Text::TemperatureText.new(extreme_values, indicators.indicators)
        expected = I18n.t("forecast_text.temperature.text_start")
        expected.concat(I18n.t("forecast_text.temperature.warmth_very_frosty"))
        expected.concat(I18n.t("forecast_text.temperature.text_day")).concat(".")
        expected.concat(I18n.t("forecast_text.temperature.text_maximum")).concat("-1")
        expected.concat(I18n.t("forecast_text.temperature.text_minimum")).concat("-8")
        expected.concat(I18n.t("forecast_text.temperature.text_finish"))
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data for a frost day" do
      it "generate and check temperature forecast text" do
        temperature_values = [ 268, 268, 268, 268, 267, 267, 267, 267, 266, 266, 
                               266, 266, 265, 265, 265, 265, 266, 266, 266, 266,
                               267, 267, 268, 268, 269, 269, 270, 270, 271, 271, 
                               272, 272, 273, 274, 271, 271, 271, 270, 270, 270,
                               269, 269, 269, 269, 268, 268, 268, 268, 268, 267
                             ]
        indicators = WrfForecast::Threshold::TemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(265.15, 274.15)
        forecast = WrfForecast::Text::TemperatureText.new(extreme_values, indicators.indicators)
        expected = I18n.t("forecast_text.temperature.text_start")
        expected.concat(I18n.t("forecast_text.temperature.warmth_cold"))
        expected.concat(I18n.t("forecast_text.temperature.text_day")).concat(".")
        expected.concat(I18n.t("forecast_text.temperature.text_maximum")).concat("1")
        expected.concat(I18n.t("forecast_text.temperature.text_minimum")).concat("-8")
        expected.concat(I18n.t("forecast_text.temperature.text_finish"))
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data for a spring day" do
      it "generate and check temperature forecast text" do
        temperature_values = [ 278, 278, 278, 278, 277, 277, 277, 277, 276, 276, 
                               276, 276, 275, 275, 275, 275, 276, 276, 276, 276,
                               277, 277, 278, 278, 279, 279, 280, 280, 281, 281, 
                               281, 281, 282, 282, 281, 281, 281, 280, 280, 280,
                               279, 279, 279, 279, 278, 278, 278, 278, 278, 277
                             ]
        indicators = WrfForecast::Threshold::TemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(275.15, 282.15)
        forecast = WrfForecast::Text::TemperatureText.new(extreme_values, indicators.indicators)
        expected = I18n.t("forecast_text.temperature.text_start")
        expected.concat(I18n.t("forecast_text.temperature.warmth_normal"))
        expected.concat(I18n.t("forecast_text.temperature.text_day")).concat(".")
        expected.concat(I18n.t("forecast_text.temperature.text_maximum")).concat("9")
        expected.concat(I18n.t("forecast_text.temperature.text_minimum")).concat("2")
        expected.concat(I18n.t("forecast_text.temperature.text_finish"))
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data for a summer day" do
      it "generate and check temperature forecast text" do
        temperature_values = [ 290, 290, 290, 290, 289, 289, 289, 289, 288, 288, 
                               289, 289, 290, 290, 291, 291, 292, 292, 293, 293,
                               294, 295, 296, 297, 298, 299, 300, 300, 300, 300, 
                               300, 301, 301, 300, 300, 299, 298, 297, 296, 295,
                               294, 294, 293, 293, 292, 292, 291, 291, 290, 290
                             ]
        indicators = WrfForecast::Threshold::TemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(288.15, 301.05)
        forecast = WrfForecast::Text::TemperatureText.new(extreme_values, indicators.indicators)
        expected = I18n.t("forecast_text.temperature.text_start")
        expected.concat(I18n.t("forecast_text.temperature.warmth_summer"))
        expected.concat(I18n.t("forecast_text.temperature.text_day")).concat(".")
        expected.concat(I18n.t("forecast_text.temperature.text_maximum")).concat("28")
        expected.concat(I18n.t("forecast_text.temperature.text_minimum")).concat("15")
        expected.concat(I18n.t("forecast_text.temperature.text_finish"))      
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data for a hot day with tropical night" do
      it "generate and check temperature forecast text" do
        temperature_values = [ 296, 296, 296, 295, 295, 295, 294, 294, 294, 294, 
                               295, 295, 296, 296, 297, 297, 298, 298, 299, 299,
                               300, 300, 301, 301, 302, 302, 303, 303, 304, 304, 
                               305, 305, 304, 304, 303, 303, 302, 302, 301, 300,
                               299, 299, 298, 298, 297, 297, 296, 296, 296, 296
                             ]
        indicators = WrfForecast::Threshold::TemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(294.15, 305.25)
        forecast = WrfForecast::Text::TemperatureText.new(extreme_values, indicators.indicators)
        expected = I18n.t("forecast_text.temperature.text_start")
        expected.concat(I18n.t("forecast_text.temperature.warmth_hot"))
        expected.concat(I18n.t("forecast_text.temperature.text_day"))
        expected.concat(I18n.t("forecast_text.temperature.warmth_tropical")).concat(".")
        expected.concat(I18n.t("forecast_text.temperature.text_maximum")).concat("33")
        expected.concat(I18n.t("forecast_text.temperature.text_minimum")).concat("21")
        expected.concat(I18n.t("forecast_text.temperature.text_finish"))
        expect(forecast.text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data for an ice day" do
      it "generate and check temperature warning text" do
        temperature_values = [ 268, 268, 268, 268, 267, 267, 267, 267, 266, 266, 
                               266, 266, 265, 265, 265, 265, 266, 266, 266, 266,
                               267, 267, 268, 268, 269, 269, 270, 270, 271, 271, 
                               271, 271, 272, 272, 271, 271, 271, 270, 270, 270,
                               269, 269, 269, 269, 268, 268, 268, 268, 268, 267
                             ]
        indicators = WrfForecast::Threshold::TemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(265.15, 272.15)
        forecast = WrfForecast::Text::TemperatureText.new(extreme_values, indicators.indicators)
        expect(forecast.warnings).to eq(I18n.t("threshold.temperature.ice_day"))
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data for a frost day" do
      it "generate and check temperature warning text" do
        temperature_values = [ 268, 268, 268, 268, 267, 267, 267, 267, 266, 266, 
                               266, 266, 265, 265, 265, 265, 266, 266, 266, 266,
                               267, 267, 268, 268, 269, 269, 270, 270, 271, 271, 
                               272, 272, 273, 274, 271, 271, 271, 270, 270, 270,
                               269, 269, 269, 269, 268, 268, 268, 268, 268, 267
                             ]
        indicators = WrfForecast::Threshold::TemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(265.15, 274.15)
        forecast = WrfForecast::Text::TemperatureText.new(extreme_values, indicators.indicators)
        expect(forecast.warnings).to eq(I18n.t("threshold.temperature.frost_day"))
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data for a spring day" do
      it "generate and check temperature forecast text" do
        temperature_values = [ 278, 278, 278, 278, 277, 277, 277, 277, 276, 276, 
                               276, 276, 275, 275, 275, 275, 276, 276, 276, 276,
                               277, 277, 278, 278, 279, 279, 280, 280, 281, 281, 
                               281, 281, 282, 282, 281, 281, 281, 280, 280, 280,
                               279, 279, 279, 279, 278, 278, 278, 278, 278, 277
                             ]
        indicators = WrfForecast::Threshold::TemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(275.15, 282.15)
        forecast = WrfForecast::Text::TemperatureText.new(extreme_values, indicators.indicators)
        expect(forecast.warnings).to be_empty
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data for a summer day" do
      it "generate and check temperature forecast text" do
        temperature_values = [ 290, 290, 290, 290, 289, 289, 289, 289, 288, 288, 
                               289, 289, 290, 290, 291, 291, 292, 292, 293, 293,
                               294, 295, 296, 297, 298, 299, 300, 300, 300, 300, 
                               300, 301, 301, 300, 300, 299, 298, 297, 296, 295,
                               294, 294, 293, 293, 292, 292, 291, 291, 290, 290
                             ]
        indicators = WrfForecast::Threshold::TemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(288.15, 301.05)
        forecast = WrfForecast::Text::TemperatureText.new(extreme_values, indicators.indicators)
        expect(forecast.warnings).to eq(I18n.t("threshold.temperature.summer_day"))
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data for a hot day with tropical night" do
      it "generate and check temperature forecast text" do
        temperature_values = [ 296, 296, 296, 295, 295, 295, 294, 294, 294, 294, 
                               295, 295, 296, 296, 297, 297, 298, 298, 299, 299,
                               300, 300, 301, 301, 302, 302, 303, 303, 304, 304, 
                               305, 305, 304, 304, 303, 303, 302, 302, 301, 300,
                               299, 299, 298, 298, 297, 297, 296, 296, 296, 296
                             ]
        indicators = WrfForecast::Threshold::TemperatureThreshold.new(temperature_values)
        extreme_values = RubyUtils::ExtremeValues.new(294.15, 305.25)
        forecast = WrfForecast::Text::TemperatureText.new(extreme_values, indicators.indicators)
        expected = I18n.t("threshold.temperature.hot_day")
        expected.concat("\n").concat(I18n.t("threshold.temperature.tropical_night"))
        expect(forecast.warnings).to eq(expected)
      end
    end
  end

end
