require "spec_helper"
require "time"
require "wrf_forecast/forecast/forecast_text"

def get_berlin_header
  expected_header = I18n.t("forecast_text.main.header_start").concat("Berlin")
  expected_header.concat(I18n.t("forecast_text.main.header_conn"))
  expected_header.concat("2020-02-23 00:00:00 +0100")
end

def get_berlin_body
  expected_body = I18n.t("forecast_text.suntime.sunrise").concat("07:07, ")
  expected_body.concat(I18n.t("forecast_text.suntime.sunset")).concat("17:34\n")

  expected_body.concat(I18n.t("forecast_text.temperature.text_start"))
  expected_body.concat(I18n.t("forecast_text.temperature.warmth_cold"))
  expected_body.concat(I18n.t("forecast_text.temperature.text_day")).concat(".")
  expected_body.concat(I18n.t("forecast_text.temperature.text_maximum")).concat("10")
  expected_body.concat(I18n.t("forecast_text.temperature.text_minimum")).concat("-4")
  expected_body.concat(I18n.t("forecast_text.temperature.text_finish")).concat("\n")


  expected_body.concat(I18n.t("forecast_text.wind.text_start"))
  expected_body.concat(I18n.t("forecast_text.wind.strength_normal"))
  expected_body.concat(I18n.t("forecast_text.wind.text_maximum")).concat("23")
  expected_body.concat(I18n.t("forecast_text.wind.text_maximum_unit"))
  expected_body.concat(I18n.t("direction.west"))
  expected_body.concat(I18n.t("forecast_text.wind.text_mean")).concat("16")
  expected_body.concat(I18n.t("forecast_text.wind.text_finish")).concat("\n")

  expected_body.concat(I18n.t("forecast_text.rain.no_rain"))
end

def get_hannover_header
  expected_header = I18n.t("forecast_text.main.header_start").concat("Hannover")
  expected_header.concat(I18n.t("forecast_text.main.header_conn"))
  expected_header.concat("2020-03-27 00:00:00 +0100")
end

def get_hannover_body
  expected_body = I18n.t("forecast_text.suntime.sunrise").concat("06:06, ")
  expected_body.concat(I18n.t("forecast_text.suntime.sunset")).concat("18:47\n")

  expected_body.concat(I18n.t("forecast_text.temperature.text_start"))
  expected_body.concat(I18n.t("forecast_text.temperature.warmth_cold"))
  expected_body.concat(I18n.t("forecast_text.temperature.text_day")).concat(".")
  expected_body.concat(I18n.t("forecast_text.temperature.text_maximum")).concat("16")
  expected_body.concat(I18n.t("forecast_text.temperature.text_minimum")).concat("-1")
  expected_body.concat(I18n.t("forecast_text.temperature.text_finish")).concat("\n")


  expected_body.concat(I18n.t("forecast_text.wind.text_start"))
  expected_body.concat(I18n.t("forecast_text.wind.strength_normal"))
  expected_body.concat(I18n.t("forecast_text.wind.text_maximum")).concat("24")
  expected_body.concat(I18n.t("forecast_text.wind.text_maximum_unit"))
  expected_body.concat(I18n.t("direction.northeast"))
  expected_body.concat(I18n.t("forecast_text.wind.text_mean")).concat("17")
  expected_body.concat(I18n.t("forecast_text.wind.text_finish")).concat("\n")

  expected_body.concat(I18n.t("forecast_text.rain.no_rain"))
end

describe WrfForecast::ForecastText do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create forecast for Berlin" do
        wrf_handler = WrfLibrary::Wrf::Handler.new(File.join(__dir__,"../files/Ber_24.d01.TS"), 
                                                  Time.parse("2020-02-23 00:00:00 +0100"))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        meta_data = wrf_handler.data_repository.meta_data
        text = WrfForecast::ForecastText.new(meta_data, repository, threshold_handler)
        expected = "#{get_berlin_header}.\n\n#{get_berlin_body}"
        expect(text.get_complete_text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      before (:all) do
        WrfForecast::LocaleConfiguration.change_locale(:de)
      end

      it "initialize handler, fill the forecast data, create text parts for Berlin" do
        wrf_handler = WrfLibrary::Wrf::Handler.new(File.join(__dir__,"../files/Ber_24.d01.TS"), 
                                                  Time.parse("2020-02-23 00:00:00 +0100"))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        meta_data = wrf_handler.data_repository.meta_data
        text = WrfForecast::ForecastText.new(meta_data, repository, threshold_handler)

        expect(text.header).to eq(get_berlin_header)
        expect(text.body).to eq(get_berlin_body)
      end
      
      after(:all) do
        WrfForecast::LocaleConfiguration.change_locale(:en)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create forecast for Hannover" do
        wrf_handler = WrfLibrary::Wrf::Handler.new(File.join(__dir__,"../files/Han_24.d01.TS"), 
                                                  Time.parse("2020-03-27 00:00:00 +0100"))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        meta_data = wrf_handler.data_repository.meta_data
        text = WrfForecast::ForecastText.new(meta_data, repository, threshold_handler)
        expected = "#{get_hannover_header}.\n\n#{get_hannover_body}"
        expect(text.get_complete_text).to eq(expected)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create text parts for Hannover" do
        wrf_handler = WrfLibrary::Wrf::Handler.new(File.join(__dir__,"../files/Han_24.d01.TS"), 
                                                  Time.parse("2020-03-27 00:00:00 +0100"))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        meta_data = wrf_handler.data_repository.meta_data
        text = WrfForecast::ForecastText.new(meta_data, repository, threshold_handler)

        expect(text.header).to eq(get_hannover_header)
        expect(text.body).to eq(get_hannover_body)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create warnings for Berlin" do
        wrf_handler = WrfLibrary::Wrf::Handler.new(File.join(__dir__,"../files/Ber_24.d01.TS"), 
                                                  Time.parse("2020-03-27 00:00:00 +0100"))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        meta_data = wrf_handler.data_repository.meta_data
        text = WrfForecast::ForecastText.new(meta_data, repository, threshold_handler)
        expected_warnings = I18n.t("forecast_text.main.warnings").concat("\n")
        expected_warnings.concat(I18n.t("threshold.temperature.frost_day"))
        expect(text.warnings).to eq(expected_warnings)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create warnings for Hannover" do
        wrf_handler = WrfLibrary::Wrf::Handler.new(File.join(__dir__,"../files/Han_24.d01.TS"), 
                                                  Time.parse("2020-03-27 00:00:00 +0100"))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        meta_data = wrf_handler.data_repository.meta_data
        text = WrfForecast::ForecastText.new(meta_data, repository, threshold_handler)
        expected_warnings = I18n.t("forecast_text.main.warnings").concat("\n")
        expected_warnings.concat(I18n.t("threshold.temperature.frost_day"))
        expect(text.warnings).to eq(expected_warnings)
      end
    end
  end

end
