#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-19 16:54:37
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-20 16:42:14

require 'spec_helper'
require 'wrf_library/wrf'
require_relative '../../lib/data/forecast_repository'
require_relative '../../lib/threshold'

describe Threshold::WindThreshold do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, check wind indicators" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), 
                                                  Date.new(2020, 02, 23))
        repository = ForecastRepository.new(handler)
        windspeed_values = repository.forecast_data[:wind_speed]
        indicators = Threshold::WindThreshold.new(windspeed_values)
        expect(indicators.indicators[:squall_day]).to eq(false)
        expect(indicators.indicators[:storm_squall_day]).to eq(false)
        expect(indicators.indicators[:storm_day]).to eq(false)
        expect(indicators.indicators[:hurricane_day]).to eq(false)
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
        indicators = Threshold::WindThreshold.new(windspeed_values)
        expect(indicators.indicators[:squall_day]).to eq(true)
        expect(indicators.indicators[:storm_squall_day]).to eq(false)
        expect(indicators.indicators[:storm_day]).to eq(false)
        expect(indicators.indicators[:hurricane_day]).to eq(false)
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
        indicators = Threshold::WindThreshold.new(windspeed_values)
        expect(indicators.indicators[:squall_day]).to eq(true)
        expect(indicators.indicators[:storm_squall_day]).to eq(true)
        expect(indicators.indicators[:storm_day]).to eq(false)
        expect(indicators.indicators[:hurricane_day]).to eq(false)
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
        indicators = Threshold::WindThreshold.new(windspeed_values)
        expect(indicators.indicators[:squall_day]).to eq(true)
        expect(indicators.indicators[:storm_squall_day]).to eq(true)
        expect(indicators.indicators[:storm_day]).to eq(true)
        expect(indicators.indicators[:hurricane_day]).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a hurricane day" do
      it "generate and check wind indicators" do
        windspeed_values = [  2,  2,  2,  2,  2,  2,  4,  4,  4,  4, 
                              8,  9,  8,  7, 10, 12, 12, 11, 13, 13,
                             14, 15, 17, 17, 21, 23, 26, 25, 26, 28, 
                             29, 30, 33, 29, 29, 27, 24, 19, 18, 20,
                             18, 16, 14, 12, 14, 15, 12, 15, 14, 12 ]
        indicators = Threshold::WindThreshold.new(windspeed_values)
        expect(indicators.indicators[:squall_day]).to eq(true)
        expect(indicators.indicators[:storm_squall_day]).to eq(true)
        expect(indicators.indicators[:storm_day]).to eq(true)
        expect(indicators.indicators[:hurricane_day]).to eq(true)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data for a normal day" do
      it "generate and check wind indicators" do
        windspeed_values = [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
                              1,  1,  1,  1,  2,  2,  2,  2,  3,  3,
                              4,  5,  7,  7,  9,  9, 11, 11, 11, 11, 
                             10, 10,  9,  9,  8,  8,  8,  7,  8,  6,
                              5,  5,  4,  3,  4,  4,  3,  2,  1,  0 ]
        indicators = Threshold::WindThreshold.new(windspeed_values)
        expect(indicators.indicators[:squall_day]).to eq(false)
        expect(indicators.indicators[:storm_squall_day]).to eq(false)
        expect(indicators.indicators[:storm_day]).to eq(false)
        expect(indicators.indicators[:hurricane_day]).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of wind data with insuffient data" do
      it "try to generate the indicators and raise error" do
        expect {
          wind_values = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
          Threshold::WindThreshold.new(wind_values)
        }.to raise_error(ArgumentError)
      end
    end
  end

end
