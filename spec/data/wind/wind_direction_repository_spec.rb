#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-12 19:16:02
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-12 20:01:47

require 'spec_helper'
require_relative '../../../lib/data/wind_direction_repository'

describe WindDirectionRepository do

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(12.5)).to match(:N)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north east" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(22.5)).to match(:N)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north east" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(42.0)).to match(:NE)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector east" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(67.5)).to match(:NE)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector east" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(91.629)).to match(:E)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south east" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(112.5)).to match(:E)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south east" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(133.7)).to match(:SE)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south east" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(157.5)).to match(:SE)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(180)).to match(:S)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(202.5)).to match(:S)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south west" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(211.7)).to match(:SW)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector south west" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(247.5)).to match(:SW)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector west" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(270.7)).to match(:W)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector west" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(292.5)).to match(:W)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north west" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(314.15)).to match(:NW)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north west" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(337.5)).to match(:NW)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(360.0)).to match(:N)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should determine the correct wind sector north" do
        repository = WindDirectionRepository.new()
        expect(repository.determine_wind_sector(0.0)).to match(:N)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should throw an argument error" do
        repository = WindDirectionRepository.new()
        expect {
          repository.determine_wind_sector(-0.1)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".determine_wind_sector" do
    context "given an object of the class" do
      it "should throw an argument error" do
        repository = WindDirectionRepository.new()
        expect {
          repository.determine_wind_sector(360.1)
        }.to raise_error(ArgumentError)
      end
    end
  end

end
  
