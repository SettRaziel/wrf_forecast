#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-12 19:16:02
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-31 16:44:31

require 'spec_helper'
require 'wrf_forecast/data/wind_direction_repository'

describe WrfForecast::WindDirectionRepository do

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(12.5)).to match(:N)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north east" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(22.5)).to match(:N)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north east" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(42.0)).to match(:NE)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector east" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(67.5)).to match(:NE)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector east" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(91.629)).to match(:E)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south east" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(112.5)).to match(:E)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south east" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(133.7)).to match(:SE)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south east" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(157.5)).to match(:SE)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(180)).to match(:S)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(202.5)).to match(:S)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south west" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(211.7)).to match(:SW)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south west" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(247.5)).to match(:SW)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector west" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(270.7)).to match(:W)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector west" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(292.5)).to match(:W)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north west" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(314.15)).to match(:NW)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north west" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(337.5)).to match(:NW)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(360.0)).to match(:N)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect(repository.determine_wind_sector(0.0)).to match(:N)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should throw an argument error" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect {
          repository.determine_wind_sector(-0.1)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should throw an argument error" do
        repository = WrfForecast::WindDirectionRepository.new()
        expect {
          repository.determine_wind_sector(360.1)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".generate_direction_distribution" do
    context "given an array with western direction data" do
      it "should determine the correct west wind distribution" do
        repository = WrfForecast::WindDirectionRepository.new()
        data = [ 240, 243, 254, 263, 270, 270, 283, 285, 295, 300 ]
        distribution = repository.generate_direction_distribution(data)
        expect(distribution[:N]).to match(0)
        expect(distribution[:NE]).to match(0)
        expect(distribution[:E]).to match(0)
        expect(distribution[:SE]).to match(0)
        expect(distribution[:S]).to match(0)
        expect(distribution[:SW]).to match(2)
        expect(distribution[:W]).to match(6)
        expect(distribution[:NW]).to match(2)
      end
    end
  end

  describe ".generate_direction_distribution" do
    context "given an array with northern direction data" do
      it "should determine the correct north wind distribution" do
        repository = WrfForecast::WindDirectionRepository.new()
        data = [ 300, 310, 337, 342, 359, 1, 0, 22, 42, 67 ]
        distribution = repository.generate_direction_distribution(data)
        expect(distribution[:N]).to match(5)
        expect(distribution[:NE]).to match(2)
        expect(distribution[:E]).to match(0)
        expect(distribution[:SE]).to match(0)
        expect(distribution[:S]).to match(0)
        expect(distribution[:SW]).to match(0)
        expect(distribution[:W]).to match(0)
        expect(distribution[:NW]).to match(3)
      end
    end
  end

end
