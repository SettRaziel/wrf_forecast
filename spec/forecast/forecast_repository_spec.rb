#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-08 18:13:30
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-20 22:02:11

require 'spec_helper'
require 'wrf_library/wrf'
require_relative '../../lib/data/forecast_repository'

describe ForecastRepository do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, check temperature values" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber.d01.TS"), Date.new(2015, 06, 29))
        repository = ForecastRepository.new(handler)
        temperature_values = repository.forecast_data[:air_temperature]
        expect(temperature_values.size).to match(3420)
        expect(temperature_values[0].round(3)).to match(280.830)
        expect(temperature_values[4].round(3)).to match(279.883)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, check temperature extremes" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber.d01.TS"), Date.new(2016, 06, 29))
        repository = ForecastRepository.new(handler)
        extreme_values = repository.extreme_values[:air_temperature]
        expect(extreme_values.maximum.round(3)).to match(283.01)
        expect(extreme_values.minimum.round(3)).to match(268.365)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, check wind speed values" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber.d01.TS"), Date.new(2017, 06, 29))
        repository = ForecastRepository.new(handler)
        windspeed_values = repository.forecast_data[:wind_speed]
        expect(windspeed_values.size).to match(3420)
        expect(windspeed_values[0].round(3)).to match(1.339)
        expect(windspeed_values[4].round(3)).to match(1.571)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, check speed extremes" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber.d01.TS"), Date.new(2018, 06, 29))
        repository = ForecastRepository.new(handler)
        extreme_values = repository.extreme_values[:wind_speed]
        expect(extreme_values.maximum.round(3)).to match(7.473)
        expect(extreme_values.minimum.round(3)).to match(1.052)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, check wind direction values" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber.d01.TS"), Date.new(2019, 06, 29))
        repository = ForecastRepository.new(handler)
        direction_values = repository.forecast_data[:wind_direction]
        expect(direction_values.size).to match(3420)
        expect(direction_values[0].round(3)).to match(50.633)
        expect(direction_values[4].round(3)).to match(50.075)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, check wind direction distribution" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber.d01.TS"), Date.new(2020, 06, 29))
        repository = ForecastRepository.new(handler)
        distribution = repository.direction_distribution
        expect(distribution[:N]).to match(306)
        expect(distribution[:NE]).to match(2799)
        expect(distribution[:E]).to match(302)
        expect(distribution[:SE]).to match(0)
        expect(distribution[:S]).to match(0)
        expect(distribution[:SW]).to match(0)
        expect(distribution[:W]).to match(0)
        expect(distribution[:NW]).to match(13)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, check rain data values" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber.d01.TS"), Date.new(2020, 06, 29))
        repository = ForecastRepository.new(handler)
        rain_data = repository.forecast_data[:rain]
        expect(rain_data.size).to match(3420)
        expect(rain_data[0].round(3)).to match(0.0)
        expect(rain_data[3419].round(3)).to match(0.679)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, check hourly rain sum values" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber.d01.TS"), Date.new(2020, 06, 29))
        repository = ForecastRepository.new(handler)
        rain_sum = repository.hourly_rain
        expect(rain_sum.size).to match(84)
        expect(rain_sum[0].round(3)).to match(0.0)
        expect(rain_sum[8].round(3)).to match(0.272)
      end
    end
  end

end
