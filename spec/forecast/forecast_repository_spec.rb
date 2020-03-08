#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-08 18:13:30
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-08 19:06:48

require 'spec_helper'
require 'wrf_library/wrf'
require_relative '../../lib/data/forecast_repository'

describe ForecastRepository do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, show temperature values" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        repository = ForecastRepository.new(handler)
        temperature_values = repository.forecast_data[:air_temperature]
        expect(temperature_values.size).to match(5)
        expect(temperature_values[0].round(3)).to match(294.716)
        expect(temperature_values[4].round(3)).to match(293.831)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, show temperature extremes" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        repository = ForecastRepository.new(handler)
        extreme_values = repository.extreme_values[:air_temperature]
        expect(extreme_values.maximum.round(3)).to match(294.716)
        expect(extreme_values.minimum.round(3)).to match(293.831)
      end
    end
  end

end
