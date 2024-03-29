require "spec_helper"
require "time"
require "wrf_forecast/forecast/suntime_text"

describe WrfForecast::Text::SuntimeText do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create suntime text for Berlin" do
        wrf_handler = WrfLibrary::Wrf::Handler.new(BERLIN_SMALL_DATA, Time.parse("2020-02-23 00:00:00 +0100"))
        meta_data = wrf_handler.data_repository.meta_data
        suntime = WrfForecast::Text::SuntimeText.new(meta_data)
        expect(suntime.text).to eq("#{I18n.t("forecast_text.suntime.sunrise")}07:07, " + \
                                   "#{I18n.t("forecast_text.suntime.sunset")}17:34")
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create suntime text for Hannover" do
        wrf_handler = WrfLibrary::Wrf::Handler.new(HANNOVER_SMALL_DATA, Time.parse("2014-06-29 00:00:00 +0200"))
        meta_data = wrf_handler.data_repository.meta_data
        suntime = WrfForecast::Text::SuntimeText.new(meta_data)
        expect(suntime.text).to eq("#{I18n.t("forecast_text.suntime.sunrise")}05:02, " + \
                                   "#{I18n.t("forecast_text.suntime.sunset")}21:47")
      end
    end
  end

end
