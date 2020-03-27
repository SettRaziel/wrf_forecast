#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-26 12:56:07
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-27 15:08:28

require 'spec_helper'
require_relative '../../lib/forecast/forecast_text'

describe ForecastText do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create forecast for Berlin" do
        wrf_handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber_24.d01.TS"), 
                                                  Date.new(2020, 02, 23))
        repository = ForecastRepository.new(wrf_handler)
        threshold_handler = Threshold::ThresholdHandler.new(repository)
        meta_data = wrf_handler.data_repository.meta_data
        forecast_text = ForecastText.new(meta_data, repository, threshold_handler)
        expected = "Weather forecast of Berlin for the 2020-02-23.\n\n"
        expected.concat('Today will be a normal day.')
        expected.concat(' The maximum temperature will reach up to 13 degrees celsius.')
        expected.concat(" The minimum temperature will be 6 degrees celsius.\n")
        expected.concat('The wind will be normal and will reach up to ')
        expected.concat("14 km/h from northeast. The mean wind will be 10 km/h.\n")
        expected.concat('The forecast does predict normal rain with a maximum of ')
        expected.concat('1 mm in 1 hour and some dry periods during the day.')
        expect(forecast_text.forecast_text).to match(expected)
      end
    end
  end

    describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create forecast for Hannover" do
        wrf_handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Han_24.d01.TS"), 
                                                  Date.new(2020, 03, 27))
        repository = ForecastRepository.new(wrf_handler)
        threshold_handler = Threshold::ThresholdHandler.new(repository)
        meta_data = wrf_handler.data_repository.meta_data
        forecast_text = ForecastText.new(meta_data, repository, threshold_handler)
        expected = "Weather forecast of Hannover for the 2020-03-27.\n\n"
        expected.concat('Today will be a cold day.')
        expected.concat(' The maximum temperature will reach up to 16 degrees celsius.')
        expected.concat(" The minimum temperature will be -1 degrees celsius.\n")
        expected.concat('The wind will be normal and will reach up to ')
        expected.concat("24 km/h from northeast. The mean wind will be 17 km/h.\n")
        expected.concat('The forecast does not predict rain.')
        expect(forecast_text.forecast_text).to match(expected)
      end
    end
  end

end
