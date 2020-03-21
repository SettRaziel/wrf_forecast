#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-19 10:01:28
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-21 20:06:53

require 'spec_helper'
require 'wrf_library/wrf'
require_relative '../../lib/threshold'

describe Threshold::TemperatureThreshold do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, check temperature indicators" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"../files/Ber_24.d01.TS"), 
                                                  Date.new(2020, 02, 23))
        temperature_values = handler.retrieve_data_set(:air_temperature)
        indicators = Threshold::TemperatureThreshold.new(temperature_values)
        expect(indicators.indicators[:ice_day]).to eq(false)
        expect(indicators.indicators[:frost_day]).to eq(false)
        expect(indicators.indicators[:summer_day]).to eq(false)
        expect(indicators.indicators[:hot_day]).to eq(false)
        expect(indicators.indicators[:tropical_night]).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data for an ice day" do
      it "generate and check temperature indicators" do
        temperature_values = [ 268, 268, 268, 268, 267, 267, 267, 267, 266, 266, 
                               266, 266, 265, 265, 265, 265, 266, 266, 266, 266,
                               267, 267, 268, 268, 269, 269, 270, 270, 271, 271, 
                               271, 271, 272, 272, 271, 271, 271, 270, 270, 270,
                               269, 269, 269, 269, 268, 268, 268, 268, 268, 267
                             ]
        indicators = Threshold::TemperatureThreshold.new(temperature_values)
        expect(indicators.indicators[:ice_day]).to eq(true)
        expect(indicators.indicators[:frost_day]).to eq(true)
        expect(indicators.indicators[:summer_day]).to eq(false)
        expect(indicators.indicators[:hot_day]).to eq(false)
        expect(indicators.indicators[:tropical_night]).to eq(false)
      end
    end
  end  

    describe ".new" do
    context "given an array of temperature data for a frost day" do
      it "generate and check temperature indicators" do
        temperature_values = [ 268, 268, 268, 268, 267, 267, 267, 267, 266, 266, 
                               266, 266, 265, 265, 265, 265, 266, 266, 266, 266,
                               267, 267, 268, 268, 269, 269, 270, 270, 271, 271, 
                               272, 272, 273, 274, 271, 271, 271, 270, 270, 270,
                               269, 269, 269, 269, 268, 268, 268, 268, 268, 267
                             ]
        indicators = Threshold::TemperatureThreshold.new(temperature_values)
        expect(indicators.indicators[:ice_day]).to eq(false)
        expect(indicators.indicators[:frost_day]).to eq(true)
        expect(indicators.indicators[:summer_day]).to eq(false)
        expect(indicators.indicators[:hot_day]).to eq(false)
        expect(indicators.indicators[:tropical_night]).to eq(false)
      end
    end
  end  

  describe ".new" do
    context "given an array of temperature data for a spring day" do
      it "generate and check temperature indicators" do
        temperature_values = [ 278, 278, 278, 278, 277, 277, 277, 277, 276, 276, 
                               276, 276, 275, 275, 275, 275, 276, 276, 276, 276,
                               277, 277, 278, 278, 279, 279, 280, 280, 281, 281, 
                               281, 281, 282, 282, 281, 281, 281, 280, 280, 280,
                               279, 279, 279, 279, 278, 278, 278, 278, 278, 277
                             ]
        indicators = Threshold::TemperatureThreshold.new(temperature_values)
        expect(indicators.indicators[:ice_day]).to eq(false)
        expect(indicators.indicators[:frost_day]).to eq(false)
        expect(indicators.indicators[:summer_day]).to eq(false)
        expect(indicators.indicators[:hot_day]).to eq(false)
        expect(indicators.indicators[:tropical_night]).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data for a summer day" do
      it "generate and check temperature indicators" do
        temperature_values = [ 290, 290, 290, 290, 289, 289, 289, 289, 288, 288, 
                               289, 289, 290, 290, 291, 291, 292, 292, 293, 293,
                               294, 295, 296, 297, 298, 299, 300, 300, 300, 300, 
                               300, 301, 301, 300, 300, 299, 298, 297, 296, 295,
                               294, 294, 293, 293, 292, 292, 291, 291, 290, 290
                             ]
        indicators = Threshold::TemperatureThreshold.new(temperature_values)
        expect(indicators.indicators[:ice_day]).to eq(false)
        expect(indicators.indicators[:frost_day]).to eq(false)
        expect(indicators.indicators[:summer_day]).to eq(true)
        expect(indicators.indicators[:hot_day]).to eq(false)
        expect(indicators.indicators[:tropical_night]).to eq(false)
      end
    end
  end  
  
  describe ".new" do
    context "given an array of temperature data for a hot day" do
      it "generate and check temperature indicators" do
        temperature_values = [ 290, 290, 290, 290, 289, 289, 289, 289, 288, 288, 
                               289, 289, 290, 290, 291, 291, 292, 292, 293, 293,
                               294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 
                               304, 304, 303, 302, 301, 300, 299, 298, 297, 296,
                               295, 294, 293, 293, 292, 292, 291, 291, 290, 290
                             ]
        indicators = Threshold::TemperatureThreshold.new(temperature_values)
        expect(indicators.indicators[:ice_day]).to eq(false)
        expect(indicators.indicators[:frost_day]).to eq(false)
        expect(indicators.indicators[:summer_day]).to eq(true)
        expect(indicators.indicators[:hot_day]).to eq(true)
        expect(indicators.indicators[:tropical_night]).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data for a hot tropical day" do
      it "generate and check temperature indicators" do
        temperature_values = [ 296, 296, 296, 295, 295, 295, 294, 294, 294, 294, 
                               295, 295, 296, 296, 297, 297, 298, 298, 299, 299,
                               300, 300, 301, 301, 302, 302, 303, 303, 304, 304, 
                               305, 305, 304, 304, 303, 303, 302, 302, 301, 300,
                               299, 299, 298, 298, 297, 297, 296, 296, 296, 296
                             ]
        indicators = Threshold::TemperatureThreshold.new(temperature_values)
        expect(indicators.indicators[:ice_day]).to eq(false)
        expect(indicators.indicators[:frost_day]).to eq(false)
        expect(indicators.indicators[:summer_day]).to eq(true)
        expect(indicators.indicators[:hot_day]).to eq(true)
        expect(indicators.indicators[:tropical_night]).to eq(true)
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data with insuffient data" do
      it "try to generate the indicators and raise error" do
        expect {
          temperature_values = [ 296, 296, 296, 295, 295, 295, 294, 294, 294, 294 ]
          Threshold::TemperatureThreshold.new(temperature_values)
        }.to raise_error(ArgumentError)
      end
    end
  end

end
