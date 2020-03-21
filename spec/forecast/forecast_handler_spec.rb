#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-21 19:45:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-21 20:07:16

require 'spec_helper'
require 'wrf_library/wrf'
require_relative '../../lib/data/forecast_repository'
require_relative '../../lib/threshold'

describe ForecastHandler do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, forecast data and handler and check initialization" do
        wrf_handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber_24.d01.TS"), 
                                                  Date.new(2020, 02, 23))
        forecast_handler = ForecastHandler.new(wrf_handler)
        expect(forecast_handler.forecast_repository).to be_truthy
        expect(forecast_handler.threshold_handler).to be_truthy
      end
    end
  end

end
