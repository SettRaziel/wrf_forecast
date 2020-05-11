#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-21 18:25:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-05-11 20:49:04

require "spec_helper"
require "wrf_library/wrf"
require "wrf_forecast/data/forecast_repository"
require "wrf_forecast/threshold"

describe WrfForecast::Threshold::ThresholdHandler do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, forecast data and handler and check initialization" do
        wrf_handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber_24.d01.TS"), 
                                                  Date.new(2020, 02, 23))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        expect(threshold_handler.temperature_threshold).to be_truthy
        expect(threshold_handler.temperature_threshold.indicators[:ice_day].is_active).to eq(false)
        expect(threshold_handler.wind_threshold).to be_truthy
        expect(threshold_handler.wind_threshold.indicators[:squall_day].is_active).to eq(false)
        expect(threshold_handler.rain_threshold).to be_truthy
        expect(threshold_handler.rain_threshold.indicators[:strong_rain].is_active).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, forecast data and handler and check threshold warnings" do
        wrf_handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber_24.d01.TS"), 
                                                  Date.new(2020, 02, 23))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        expect(threshold_handler.warnings[:air_temperature][0].identifier).to eq(:frost_day)
        expect(threshold_handler.warnings[:wind_speed]).to be_empty
        expect(threshold_handler.warnings[:rain]).to be_empty
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, forecast data and handler and check threshold warnings" do
        wrf_handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Han_24.d01.TS"), 
                                                  Date.new(2020, 02, 23))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        expect(threshold_handler.warnings[:air_temperature][0].identifier).to eq(:frost_day)
        expect(threshold_handler.warnings[:wind_speed]).to be_empty
        expect(threshold_handler.warnings[:rain]).to be_empty
      end
    end
  end

end
