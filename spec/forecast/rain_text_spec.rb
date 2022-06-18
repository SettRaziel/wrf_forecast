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
        expected = I18n.t("forecast_text.rain.rain_start")
        expected.concat(I18n.t("forecast_text.rain.intensity_normal"))
        expected.concat(" ").concat(I18n.t("forecast_text.preciptation_form.liquid"))
        expected.concat(I18n.t("forecast_text.rain.text_maximum"))
        expected.concat("2").concat(I18n.t("forecast_text.rain.text_amount_hour"))
        expected.concat("8").concat(I18n.t("forecast_text.rain.text_amount_day"))
        expected.concat(I18n.t("forecast_text.rain.text_period_start"))
        expected.concat(I18n.t("forecast_text.rain.text_period_some_dry"))
        expected.concat(I18n.t("forecast_text.rain.text_period_finish"))
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
        expected = I18n.t("forecast_text.rain.rain_start")
        expected.concat(I18n.t("forecast_text.rain.intensity_strong"))
        expected.concat(" ").concat(I18n.t("forecast_text.preciptation_form.liquid"))        
        expected.concat(I18n.t("forecast_text.rain.text_maximum"))
        expected.concat("16").concat(I18n.t("forecast_text.rain.text_amount_hour"))
        expected.concat("33").concat(I18n.t("forecast_text.rain.text_amount_day"))
        expected.concat(I18n.t("forecast_text.rain.text_period_start"))
        expected.concat(I18n.t("forecast_text.rain.text_period_some_dry"))
        expected.concat(I18n.t("forecast_text.rain.text_period_finish"))
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
        expected = I18n.t("forecast_text.rain.rain_start")
        expected.concat(I18n.t("forecast_text.rain.intensity_heavy"))
        expected.concat(" ").concat(I18n.t("forecast_text.preciptation_form.liquid"))
        expected.concat(I18n.t("forecast_text.rain.text_maximum"))
        expected.concat("26").concat(I18n.t("forecast_text.rain.text_amount_hour"))
        expected.concat("33").concat(I18n.t("forecast_text.rain.text_amount_day"))
        expected.concat(I18n.t("forecast_text.rain.text_period_start"))
        expected.concat(I18n.t("forecast_text.rain.text_period_some_dry"))
        expected.concat(I18n.t("forecast_text.rain.text_period_finish"))
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
        expected = I18n.t("forecast_text.rain.rain_start")
        expected.concat(I18n.t("forecast_text.rain.intensity_extreme"))
        expected.concat(" ").concat(I18n.t("forecast_text.preciptation_form.liquid"))
        expected.concat(I18n.t("forecast_text.rain.text_maximum"))
        expected.concat("41").concat(I18n.t("forecast_text.rain.text_amount_hour"))
        expected.concat("43").concat(I18n.t("forecast_text.rain.text_amount_day"))
        expected.concat(I18n.t("forecast_text.rain.text_period_start"))
        expected.concat(I18n.t("forecast_text.rain.text_period_some_dry"))
        expected.concat(I18n.t("forecast_text.rain.text_period_finish"))
        expect(forecast.text).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with continous rain and no dry period" do
      it "generate and check rain forecast text" do
        rain_values = [  2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 
                         2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 
                         1,  1,  1,  1 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(1, 2)
        forecast = WrfForecast::Text::RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = I18n.t("forecast_text.rain.rain_start")
        expected.concat(I18n.t("forecast_text.rain.intensity_continous"))
        expected.concat(" ").concat(I18n.t("forecast_text.preciptation_form.liquid"))
        expected.concat(I18n.t("forecast_text.rain.text_maximum"))
        expected.concat("44").concat(I18n.t("forecast_text.rain.text_continous"))
        expected.concat(I18n.t("forecast_text.rain.text_period_start"))
        expected.concat(I18n.t("forecast_text.rain.text_period_no_dry"))
        expected.concat(I18n.t("forecast_text.rain.text_period_finish"))
        expect(forecast.text).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with continous rain and a dry period" do
      it "generate and check rain forecast text" do
        rain_values = [  2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 
                         2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 
                         1,  1,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        extreme_values = RubyUtils::ExtremeValues.new(0, 2)
        forecast = WrfForecast::Text::RainText.new(extreme_values, rain_values, indicators.indicators)
        expected = I18n.t("forecast_text.rain.rain_start")
        expected.concat(I18n.t("forecast_text.rain.intensity_continous"))
        expected.concat(" ").concat(I18n.t("forecast_text.preciptation_form.liquid"))
        expected.concat(I18n.t("forecast_text.rain.text_maximum"))
        expected.concat("42").concat(I18n.t("forecast_text.rain.text_continous"))
        expected.concat(I18n.t("forecast_text.rain.text_period_start"))
        expected.concat(I18n.t("forecast_text.rain.text_period_some_dry"))
        expected.concat(I18n.t("forecast_text.rain.text_period_finish"))
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
        expect(forecast.warnings).to eq(I18n.t("threshold.rain.strong_rain"))
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
        expect(forecast.warnings).to match(I18n.t("threshold.rain.heavy_rain"))
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
        expect(forecast.warnings).to match(I18n.t("threshold.rain.extreme_rain"))
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
        expect(forecast.warnings).to match(I18n.t("threshold.rain.continous_rain"))
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
        expected = I18n.t("threshold.rain.strong_rain")
        expected.concat("\n").concat(I18n.t("threshold.rain.continous_rain"))
        expect(forecast.warnings).to match(expected)
      end
    end
  end

end
