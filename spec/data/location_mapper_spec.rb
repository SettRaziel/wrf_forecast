#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-06-06 09:11:26
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-06-06 10:05:57

require "spec_helper"
require "wrf_forecast/data/location_mapping"

describe WrfForecast::Location::LocationMapping do

  describe ".get_file_to_location" do
    context "given a csv file with location" do
      it "read the file and returns the correct location to the key" do
        locations = WrfForecast::Location::LocationMapping.new(File.join(__dir__,"../files/locations.csv"))
        expect(locations.get_file_to_location("Ber")).to eq("Berlin")
      end
    end
  end

  describe ".get_file_to_location" do
    context "given a csv file with location" do
      it "read the file and returns nil for an unknown key" do
        locations = WrfForecast::Location::LocationMapping.new(File.join(__dir__,"../files/locations.csv"))
        expect(locations.get_file_to_location("Hil")).to be_nil
      end
    end
  end

  describe ".new" do
    context "given a csv file with invalid location pairs" do
      # prepare temporary output file
      filename = "../files/locations_fail.csv"
      output = File.new(File.join(__dir__, filename), "w")
      output.puts("wrong;csv;file")
      output.close
      
      it "try to read the file and throw an error" do
        expect { 
          WrfForecast::Location::LocationMapping.new(File.join(__dir__, filename))
        }.to raise_error(ArgumentError)
      end

      # clean up file
      after(:all) do
        File.delete(File.join(__dir__,filename))
      end
    end
  end

end
