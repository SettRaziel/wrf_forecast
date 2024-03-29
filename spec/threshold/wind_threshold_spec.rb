require "spec_helper"
require "time"
require "wrf_library/wrf"
require "wrf_forecast/data/forecast_repository"
require "wrf_forecast/threshold"

describe WrfForecast::Threshold::WindThreshold do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, check wind indicators" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_SMALL_DATA, Time.parse("2020-02-23"))
        repository = WrfForecast::ForecastRepository.new(handler)
        windspeed_values = repository.forecast_data[:wind_speed]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        expect(indicators.indicators[:windy_day].is_active).to eq(false)        
        expect(indicators.indicators[:squall_day].is_active).to eq(false)
        expect(indicators.indicators[:storm_squall_day].is_active).to eq(false)
        expect(indicators.indicators[:storm_day].is_active).to eq(false)
        expect(indicators.indicators[:hurricane_day].is_active).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a squall day" do
      it "generate and check wind indicators" do
        windspeed_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                              1,  1,  1,  1,  2,  2,  2,  2,  3,  3,
                              4,  5,  7,  7,  9,  9, 11, 11, 11, 11, 
                             12, 12, 14, 16, 13, 17, 14, 17, 18, 20,
                             18, 16, 14, 12, 10,  8,  6,  5,  5,  5 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        expect(indicators.indicators[:windy_day].is_active).to eq(true)        
        expect(indicators.indicators[:squall_day].is_active).to eq(true)
        expect(indicators.indicators[:storm_squall_day].is_active).to eq(false)
        expect(indicators.indicators[:storm_day].is_active).to eq(false)
        expect(indicators.indicators[:hurricane_day].is_active).to eq(false)
      end
    end
  end  

    describe ".new" do
    context "given an array of wind data for a storm squall day" do
      it "generate and check wind indicators" do
        windspeed_values = [  2,  2,  2,  2,  2,  2,  4,  4,  4,  4, 
                              8,  9,  8,  7, 10, 12, 12, 11, 13, 13,
                             14, 15, 17, 17, 19, 19, 21, 21, 21, 21, 
                             22, 22, 24, 26, 23, 27, 24, 19, 18, 20,
                             18, 16, 14, 12, 10,  8,  6,  5,  5,  5 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        expect(indicators.indicators[:windy_day].is_active).to eq(true)        
        expect(indicators.indicators[:squall_day].is_active).to eq(true)
        expect(indicators.indicators[:storm_squall_day].is_active).to eq(true)
        expect(indicators.indicators[:storm_day].is_active).to eq(false)
        expect(indicators.indicators[:hurricane_day].is_active).to eq(false)
      end
    end
  end  

  describe ".new" do
    context "given an array of wind data for a storm day" do
      it "generate and check wind indicators" do
        windspeed_values = [  2,  2,  2,  2,  2,  2,  4,  4,  4,  4, 
                              8,  9,  8,  7, 10, 12, 12, 11, 13, 13,
                             14, 15, 17, 17, 19, 19, 21, 21, 21, 21, 
                             22, 24, 27, 29, 29, 27, 24, 19, 18, 20,
                             18, 16, 14, 12, 10,  8,  6,  5,  5,  5 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        expect(indicators.indicators[:windy_day].is_active).to eq(true)      
        expect(indicators.indicators[:squall_day].is_active).to eq(true)
        expect(indicators.indicators[:storm_squall_day].is_active).to eq(true)
        expect(indicators.indicators[:storm_day].is_active).to eq(true)
        expect(indicators.indicators[:hurricane_day].is_active).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a hurricane day" do
      it "generate and check wind indicators" do
        windspeed_values = [  2,  2,  2,  2,  2,  2,  4,  4,  4,  4, 
                              8,  9,  8,  7, 10, 12, 12, 11, 13, 13,
                             14, 15, 17, 17, 21, 23, 26, 25, 26, 28, 
                             29, 30, 34, 29, 29, 27, 24, 19, 18, 20,
                             18, 16, 14, 12, 14, 15, 12, 15, 14, 12 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        expect(indicators.indicators[:windy_day].is_active).to eq(true)
        expect(indicators.indicators[:squall_day].is_active).to eq(true)
        expect(indicators.indicators[:storm_squall_day].is_active).to eq(true)
        expect(indicators.indicators[:storm_day].is_active).to eq(true)
        expect(indicators.indicators[:hurricane_day].is_active).to eq(true)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a windy day" do
      it "generate and check wind indicators" do
        windspeed_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                              1,  1,  1,  1,  2,  2,  2,  2,  3,  3,
                              4,  5,  7,  7,  9,  9, 11, 11, 11, 11, 
                             10, 10,  9,  9,  8,  8,  8,  7,  8,  6,
                              5,  5,  4,  3,  4,  4,  3,  2,  1,  0 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        expect(indicators.indicators[:windy_day].is_active).to eq(true)
        expect(indicators.indicators[:squall_day].is_active).to eq(false)
        expect(indicators.indicators[:storm_squall_day].is_active).to eq(false)
        expect(indicators.indicators[:storm_day].is_active).to eq(false)
        expect(indicators.indicators[:hurricane_day].is_active).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a normal day" do
      it "generate and check wind indicators" do
        windspeed_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                              1,  1,  1,  1,  2,  2,  2,  2,  3,  3,
                              4,  5,  7,  7,  9,  9,  8,  8,  8,  8, 
                              9,  9,  9,  9,  8,  8,  8,  7,  8,  6,
                              5,  5,  4,  3,  4,  4,  3,  2,  1,  0 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        expect(indicators.indicators[:windy_day].is_active).to eq(false)
        expect(indicators.indicators[:squall_day].is_active).to eq(false)
        expect(indicators.indicators[:storm_squall_day].is_active).to eq(false)
        expect(indicators.indicators[:storm_day].is_active).to eq(false)
        expect(indicators.indicators[:hurricane_day].is_active).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data with insuffient data" do
      it "try to generate the indicators and raise error" do
        expect {
          wind_values = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
          WrfForecast::Threshold::WindThreshold.new(wind_values)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a normal day" do
      it "generate and check wind threshold texts" do
        windspeed_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                              1,  1,  1,  1,  2,  2,  2,  2,  3,  3,
                              4,  5,  7,  7,  9,  9,  8,  8,  8,  8, 
                              9,  9,  9,  9,  8,  8,  8,  7,  8,  6,
                              5,  5,  4,  3,  4,  4,  3,  2,  1,  0 ]
        indicators = WrfForecast::Threshold::WindThreshold.new(windspeed_values)
        expect(indicators.indicators[:windy_day].warning_text).to eq(I18n.t("threshold.wind.windy_day"))
        expect(indicators.indicators[:squall_day].warning_text).to eq(I18n.t("threshold.wind.squall_day"))
        expect(indicators.indicators[:storm_squall_day].warning_text).to eq(I18n.t("threshold.wind.storm_squall_day"))
        expect(indicators.indicators[:storm_day].warning_text).to eq(I18n.t("threshold.wind.storm_day"))
        expect(indicators.indicators[:hurricane_day].warning_text).to eq(I18n.t("threshold.wind.hurricane_day"))
      end
    end
  end

end
