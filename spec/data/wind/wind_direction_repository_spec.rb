#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-12 19:16:02
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-10-06 21:30:21

require "spec_helper"
require "wrf_forecast/data/wind_direction_repository"

describe WrfForecast::WindDirectionRepository do
  repository = WrfForecast::WindDirectionRepository.new()
  
  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north" do
        expect(repository.determine_wind_sector(12.5)).to eq(:N)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north east" do
        expect(repository.determine_wind_sector(22.5)).to eq(:N)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north east" do
        expect(repository.determine_wind_sector(42.0)).to eq(:NE)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector east" do
        expect(repository.determine_wind_sector(67.5)).to eq(:NE)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector east" do
        expect(repository.determine_wind_sector(91.629)).to eq(:E)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south east" do
        expect(repository.determine_wind_sector(112.5)).to eq(:E)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south east" do
        expect(repository.determine_wind_sector(133.7)).to eq(:SE)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south east" do
        expect(repository.determine_wind_sector(157.5)).to eq(:SE)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south" do
        expect(repository.determine_wind_sector(180)).to eq(:S)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south" do
        expect(repository.determine_wind_sector(202.5)).to eq(:S)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south west" do
        expect(repository.determine_wind_sector(211.7)).to eq(:SW)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south west" do
        expect(repository.determine_wind_sector(247.5)).to eq(:SW)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector west" do
        expect(repository.determine_wind_sector(270.7)).to eq(:W)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector west" do
        expect(repository.determine_wind_sector(292.5)).to eq(:W)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north west" do
        expect(repository.determine_wind_sector(314.15)).to eq(:NW)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north west" do
        expect(repository.determine_wind_sector(337.5)).to eq(:NW)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north" do
        expect(repository.determine_wind_sector(360.0)).to eq(:N)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north" do
        expect(repository.determine_wind_sector(0.0)).to eq(:N)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should throw an argument error" do
        expect {
          repository.determine_wind_sector(-0.1)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should throw an argument error" do
        expect {
          repository.determine_wind_sector(360.1)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".generate_direction_distribution" do
    context "given an array with western direction data" do
      it "should determine the correct west wind distribution" do
        # new instance for the wind distribution
        repository = WrfForecast::WindDirectionRepository.new()
        data = [ 240, 243, 254, 263, 270, 270, 283, 285, 295, 300 ]
        distribution = repository.generate_direction_distribution(data)
        expect(distribution[:N]).to eq(0)
        expect(distribution[:NE]).to eq(0)
        expect(distribution[:E]).to eq(0)
        expect(distribution[:SE]).to eq(0)
        expect(distribution[:S]).to eq(0)
        expect(distribution[:SW]).to eq(2)
        expect(distribution[:W]).to eq(6)
        expect(distribution[:NW]).to eq(2)
      end
    end
  end

  describe ".generate_direction_distribution" do
    context "given an array with northern direction data" do
      it "should determine the correct north wind distribution" do
        # new instance for the wind distribution
        repository = WrfForecast::WindDirectionRepository.new()
        data = [ 300, 310, 337, 342, 359, 1, 0, 22, 42, 67 ]
        distribution = repository.generate_direction_distribution(data)
        expect(distribution[:N]).to eq(5)
        expect(distribution[:NE]).to eq(2)
        expect(distribution[:E]).to eq(0)
        expect(distribution[:SE]).to eq(0)
        expect(distribution[:S]).to eq(0)
        expect(distribution[:SW]).to eq(0)
        expect(distribution[:W]).to eq(0)
        expect(distribution[:NW]).to eq(3)
      end
    end
  end

end
