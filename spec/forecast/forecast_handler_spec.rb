#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-21 19:45:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-11-15 20:52:43

require "spec_helper"
require "time"
require "wrf_library/wrf"
require "wrf_forecast/data/forecast_repository"
require "wrf_forecast/threshold"
require "wrf_forecast/forecast/forecast_handler"

describe WrfForecast::ForecastHandler do
  wrf_handler = WrfLibrary::Wrf::Handler.new(File.join(__dir__,"../files/Ber_24.d01.TS"), 
                                            Time.parse("2020-02-23"))

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, forecast data and handler and check initialization" do
        forecast_handler = WrfForecast::ForecastHandler.new(wrf_handler)
        expect(forecast_handler.repository).to be_truthy
        expect(forecast_handler.threshold_handler).to be_truthy
        expect(forecast_handler.text).to be_truthy
      end
    end
  end

  describe ".generate_json_output" do
    context "given a meteogram output file and the date" do
      it "initialize handler, forecast data and handler and check initialization" do
        forecast_handler = WrfForecast::ForecastHandler.new(wrf_handler)
        expect(forecast_handler.generate_json_output.empty?).to be_falsy
      end
    end
  end

end
