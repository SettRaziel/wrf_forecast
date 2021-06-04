#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2021-01-12 22:14:15
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-01-13 20:21:16

require "spec_helper"
require "time"
require "wrf_forecast/forecast/english/suntime_text"

describe WrfForecast::Text::SuntimeText do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create suntime text for Berlin" do
        wrf_handler = WrfLibrary::Wrf::Handler.new(BERLIN_SMALL_DATA, Time.parse("2020-02-23 00:00:00 +0100"))
        meta_data = wrf_handler.data_repository.meta_data
        suntime = WrfForecast::Text::SuntimeText.new(meta_data)
        expect(suntime.text).to eq("Sunrise: 07:07, Sunset: 17:34")
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, create suntime text for Hannover" do
        wrf_handler = WrfLibrary::Wrf::Handler.new(File.join(__dir__,"../files/Han_24.d01.TS"), 
                                                  Time.parse("2014-06-29 00:00:00 +0200"))
        meta_data = wrf_handler.data_repository.meta_data
        suntime = WrfForecast::Text::SuntimeText.new(meta_data)
        expect(suntime.text).to eq("Sunrise: 05:02, Sunset: 21:47")
      end
    end
  end

end
