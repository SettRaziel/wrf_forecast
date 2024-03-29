require "spec_helper"
require "wrf_library/wrf"
require "wrf_forecast/data/forecast_repository"
require "wrf_forecast/threshold"

describe WrfForecast::Threshold::RainThreshold do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, check rain indicators" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_SMALL_DATA, Time.parse("2020-02-23"))
        repository = WrfForecast::ForecastRepository.new(handler)
        rain_values = repository.hourly_rain
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        expect(indicators.indicators[:strong_rain].is_active).to eq(false)
        expect(indicators.indicators[:heavy_rain].is_active).to eq(false)
        expect(indicators.indicators[:extreme_rain].is_active).to eq(false)
        expect(indicators.indicators[:continous_rain].is_active).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a normal day" do
      it "generate and check rain indicators" do
        rain_values = [  0,  1,  1,  2,  2,  1,  1,  0,  0,  0, 
                         0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  0,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        expect(indicators.indicators[:strong_rain].is_active).to eq(false)
        expect(indicators.indicators[:heavy_rain].is_active).to eq(false)
        expect(indicators.indicators[:extreme_rain].is_active).to eq(false)
        expect(indicators.indicators[:continous_rain].is_active).to eq(false)
      end
    end
  end  

    describe ".new" do
    context "given an array of rain data for a day with strong rain" do
      it "generate and check rain indicators" do
        rain_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  1, 16,  1,  0,  0,  0, 10,  5,  0, 
                         0,  0,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        expect(indicators.indicators[:strong_rain].is_active).to eq(true)
        expect(indicators.indicators[:heavy_rain].is_active).to eq(false)
        expect(indicators.indicators[:extreme_rain].is_active).to eq(false)
        expect(indicators.indicators[:continous_rain].is_active).to eq(false)
      end
    end
  end  

  describe ".new" do
    context "given an array of rain data for a day with heavy rain" do
      it "generate and check rain indicators" do
        rain_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  1, 26,  1,  0,  0,  0,  0,  5,  0, 
                         0,  0,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        expect(indicators.indicators[:strong_rain].is_active).to eq(true)
        expect(indicators.indicators[:heavy_rain].is_active).to eq(true)
        expect(indicators.indicators[:extreme_rain].is_active).to eq(false)
        expect(indicators.indicators[:continous_rain].is_active).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with extreme rain" do
      it "generate and check rain indicators" do
        rain_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  1, 41,  1,  0,  0,  0,  0,  0,  0, 
                         0,  0,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        expect(indicators.indicators[:strong_rain].is_active).to eq(true)
        expect(indicators.indicators[:heavy_rain].is_active).to eq(true)
        expect(indicators.indicators[:extreme_rain].is_active).to eq(true)
        expect(indicators.indicators[:continous_rain].is_active).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a day with continous rain" do
      it "generate and check rain indicators" do
        rain_values = [  2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 
                         2,  2,  2,  2,  2,  2,  2,  2,  2,  2, 
                         0,  0,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        expect(indicators.indicators[:strong_rain].is_active).to eq(false)
        expect(indicators.indicators[:heavy_rain].is_active).to eq(false)
        expect(indicators.indicators[:extreme_rain].is_active).to eq(false)
        expect(indicators.indicators[:continous_rain].is_active).to eq(true)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data with insuffient data" do
      it "try to generate the indicators and raise error" do
        expect {
          rain_values = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
          WrfForecast::Threshold::RainThreshold.new(rain_values)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".new" do
    context "given an array of rain data for a normal day" do
      it "generate and check rain threshold texts" do
        rain_values = [  0,  1,  1,  2,  2,  1,  1,  0,  0,  0, 
                         0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                         0,  0,  0,  0 ]
        indicators = WrfForecast::Threshold::RainThreshold.new(rain_values)
        expect(indicators.indicators[:strong_rain].warning_text).to eq(I18n.t("threshold.rain.strong_rain"))
        expect(indicators.indicators[:heavy_rain].warning_text).to eq(I18n.t("threshold.rain.heavy_rain"))
        expect(indicators.indicators[:extreme_rain].warning_text).to eq(I18n.t("threshold.rain.extreme_rain"))
        expect(indicators.indicators[:continous_rain].warning_text).to eq(I18n.t("threshold.rain.continous_rain"))
      end
    end
  end  

end
