#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-26 12:56:07
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-21 17:32:33

require 'spec_helper'
require 'wrf_forecast/forecast/forecast_text'

describe WrfForecast::ForecastText do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create forecast for Berlin" do
        wrf_handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber_24.d01.TS"), 
                                                  Date.new(2020, 02, 23))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        meta_data = wrf_handler.data_repository.meta_data
        text = WrfForecast::ForecastText.new(meta_data, repository, threshold_handler)
        expected = "Weather forecast of Berlin for the 2020-02-23.\n\n"
        expected.concat('Today will be a cold day.')
        expected.concat(' The maximum temperature will reach up to 10 degrees celsius.')
        expected.concat(" The minimum temperature will be -4 degrees celsius.\n")
        expected.concat('The wind will be normal and will reach up to ')
        expected.concat("23 km/h from west. The mean wind will be 16 km/h.\n")
        expected.concat('The forecast does not predict rain.')
        expect(text.get_complete_text).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create text parts for Berlin" do
        wrf_handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber_24.d01.TS"), 
                                                  Date.new(2020, 02, 23))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        meta_data = wrf_handler.data_repository.meta_data
        text = WrfForecast::ForecastText.new(meta_data, repository, threshold_handler)
        expected_header = 'Weather forecast of Berlin for the 2020-02-23'
        expected_body = 'Today will be a cold day.'
        expected_body.concat(' The maximum temperature will reach up to 10 degrees celsius.')
        expected_body.concat(" The minimum temperature will be -4 degrees celsius.\n")
        expected_body.concat('The wind will be normal and will reach up to ')
        expected_body.concat("23 km/h from west. The mean wind will be 16 km/h.\n")
        expected_body.concat('The forecast does not predict rain.')
        expect(text.header).to match(expected_header)
        expect(text.body).to match(expected_body)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create forecast for Hannover" do
        wrf_handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Han_24.d01.TS"), 
                                                  Date.new(2020, 03, 27))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        meta_data = wrf_handler.data_repository.meta_data
        text = WrfForecast::ForecastText.new(meta_data, repository, threshold_handler)
        expected = "Weather forecast of Hannover for the 2020-03-27.\n\n"
        expected.concat('Today will be a cold day.')
        expected.concat(' The maximum temperature will reach up to 16 degrees celsius.')
        expected.concat(" The minimum temperature will be -1 degrees celsius.\n")
        expected.concat('The wind will be normal and will reach up to ')
        expected.concat("24 km/h from northeast. The mean wind will be 17 km/h.\n")
        expected.concat('The forecast does not predict rain.')
        expect(text.get_complete_text).to match(expected)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create text parts for Hannover" do
        wrf_handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Han_24.d01.TS"), 
                                                  Date.new(2020, 03, 27))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        meta_data = wrf_handler.data_repository.meta_data
        text = WrfForecast::ForecastText.new(meta_data, repository, threshold_handler)
        expected_header = 'Weather forecast of Hannover for the 2020-03-27'
        expected_body = 'Today will be a cold day.'
        expected_body.concat(' The maximum temperature will reach up to 16 degrees celsius.')
        expected_body.concat(" The minimum temperature will be -1 degrees celsius.\n")
        expected_body.concat('The wind will be normal and will reach up to ')
        expected_body.concat("24 km/h from northeast. The mean wind will be 17 km/h.\n")
        expected_body.concat('The forecast does not predict rain.')
        expect(text.header).to match(expected_header)
        expect(text.body).to match(expected_body)
      end
    end
  end

end
