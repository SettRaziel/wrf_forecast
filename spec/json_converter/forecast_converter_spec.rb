#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-08-03 18:31:20
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-08-17 14:59:46

require 'spec_helper'
require 'wrf_forecast/json_converter'
require 'fileutils'

describe WrfForecast::JsonConverter::ForecastJsonConverter do

  describe ".convert" do
    context "given a meteogram output file" do
      it "read it and create the correct json output" do
        wrf_handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber_24.d01.TS"), Date.new(2020, 06, 29))
        forecast_handler = WrfForecast::ForecastHandler.new(wrf_handler)
        warnings = forecast_handler.threshold_handler.warnings
        converter = WrfForecast::JsonConverter::ForecastJsonConverter.
                    new(wrf_handler.data_repository, forecast_handler.repository, forecast_handler.threshold_handler.warnings)
        converter.convert(__dir__)
        expect(FileUtils.compare_file(File.join(__dir__,"output.json"), File.join(__dir__,"../files/expected_output.json"))).to be_truthy

        # clean up data from the test and catch errors since they should not let the test fail
        File.delete(File.join(__dir__,"output.json"))
      end
    end
  end

end
