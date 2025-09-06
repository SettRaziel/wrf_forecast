require "spec_helper"
require "time"
require "wrf_library/wrf"
require "wrf_forecast/threshold"

describe WrfForecast::Threshold::ApparentTemperatureThreshold do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, check apparent temperature indicators" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_SMALL_DATA, Time.parse("2020-02-23"))
        repository = WrfForecast::ForecastRepository.new(handler)
        temperature_values = repository.forecast_data[:apparent_temperature]
        indicators = WrfForecast::Threshold::ApparentTemperatureThreshold.new(temperature_values)
        expect(indicators.indicators[:strong_heat_day].is_active).to eq(false)
        expect(indicators.indicators[:extreme_heat_day].is_active).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data for a strong heat day" do
      it "generate and check temperature indicators" do
        temperature_values = [ 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
                               29, 29, 29, 29, 29, 29, 29, 29, 29, 29,
                               31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
                               33, 33, 33, 33, 33, 33, 33, 33, 33, 33,
                               35, 35, 35, 35, 35, 35, 35, 35, 35, 35
                             ]
        indicators = WrfForecast::Threshold::ApparentTemperatureThreshold.new(temperature_values)
        expect(indicators.indicators[:strong_heat_day].is_active).to eq(true)
        expect(indicators.indicators[:extreme_heat_day].is_active).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data for an extreme heat day" do
      it "generate and check temperature indicators" do
        temperature_values = [ 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
                               29, 29, 29, 29, 29, 29, 29, 29, 29, 29,
                               31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
                               33, 33, 33, 33, 33, 33, 33, 33, 33, 33,
                               35, 35, 35, 35, 39, 39, 35, 35, 35, 35
                             ]
        indicators = WrfForecast::Threshold::ApparentTemperatureThreshold.new(temperature_values)
        expect(indicators.indicators[:strong_heat_day].is_active).to eq(true)
        expect(indicators.indicators[:extreme_heat_day].is_active).to eq(true)
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data with insuffient data" do
      it "try to generate the indicators and raise error" do
        expect {
          temperature_values = [ 296, 296, 296, 295, 295, 295, 294, 294, 294, 294 ]
          WrfForecast::Threshold::ApparentTemperatureThreshold.new(temperature_values)
        }.to raise_error(ArgumentError)
      end
    end
  end

end
