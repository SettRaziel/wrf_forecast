require "spec_helper"
require "time"
require "wrf_library/wrf"
require "wrf_forecast/threshold"

describe WrfForecast::Threshold::PressureThreshold do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "initialize handler, fill the forecast data, check pressure indicators" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_SMALL_DATA, Time.parse("2020-02-23"))
        pressure_values = handler.retrieve_data_set(:pressure)
        indicators = WrfForecast::Threshold::PressureThreshold.new(pressure_values)
        expect(indicators.indicators[:low_pressure].is_active).to eq(false)
        expect(indicators.indicators[:very_low_pressure].is_active).to eq(false)
        expect(indicators.indicators[:high_pressure].is_active).to eq(true)
        expect(indicators.indicators[:very_high_pressure].is_active).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of pressure data for a low pressure day" do
      it "generate and check pressure indicators" do
        pressure_values = [ 101300, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101170, 101160, 101050, 101040, 101030, 100950, 100920,
                            100900, 101290, 101280, 101270, 100860, 101250, 101240, 100730, 100700, 100620,
                            100600, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            100300, 100290, 100280, 100270, 100260, 100250, 101240, 101230, 101220, 101220
                          ]
        indicators = WrfForecast::Threshold::PressureThreshold.new(pressure_values)
        expect(indicators.indicators[:low_pressure].is_active).to eq(true)
        expect(indicators.indicators[:very_low_pressure].is_active).to eq(false)
        expect(indicators.indicators[:high_pressure].is_active).to eq(false)
        expect(indicators.indicators[:very_high_pressure].is_active).to eq(false)
      end
    end
  end  

    describe ".new" do
    context "given an array of pressure data for a very low pressure day" do
      it "generate and check pressure indicators" do
        pressure_values = [ 101300, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101170, 101160, 101050, 101040, 101030, 100950, 100920,
                            100900, 101290, 101280, 101270, 100860, 101250, 101240, 100730, 100700, 100620,
                            100600, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            100300, 100290, 100280, 100270, 100260, 100250, 101240, 101230, 101220, 98920
                          ]
        indicators = WrfForecast::Threshold::PressureThreshold.new(pressure_values)
        expect(indicators.indicators[:low_pressure].is_active).to eq(true)
        expect(indicators.indicators[:very_low_pressure].is_active).to eq(true)
        expect(indicators.indicators[:high_pressure].is_active).to eq(false)
        expect(indicators.indicators[:very_high_pressure].is_active).to eq(false)
      end
    end
  end  

    describe ".new" do
    context "given an array of pressure data for a high pressure day" do
      it "generate and check pressure indicators" do
        pressure_values = [ 102100, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101170, 101160, 101050, 101040, 101030, 100950, 100920,
                            100900, 101290, 101280, 101270, 100860, 101250, 101240, 100730, 100700, 100620,
                            100600, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101200
                          ]
        indicators = WrfForecast::Threshold::PressureThreshold.new(pressure_values)
        expect(indicators.indicators[:low_pressure].is_active).to eq(false)
        expect(indicators.indicators[:very_low_pressure].is_active).to eq(false)
        expect(indicators.indicators[:high_pressure].is_active).to eq(true)
        expect(indicators.indicators[:very_high_pressure].is_active).to eq(false)
      end
    end
  end

      describe ".new" do
    context "given an array of pressure data for a very high pressure day" do
      it "generate and check pressure indicators" do
        pressure_values = [ 103600, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101170, 101160, 101050, 101040, 101030, 100950, 100920,
                            100900, 101290, 101280, 101270, 100860, 101250, 101240, 100730, 100700, 100620,
                            100600, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101200
                          ]
        indicators = WrfForecast::Threshold::PressureThreshold.new(pressure_values)
        expect(indicators.indicators[:low_pressure].is_active).to eq(false)
        expect(indicators.indicators[:very_low_pressure].is_active).to eq(false)
        expect(indicators.indicators[:high_pressure].is_active).to eq(true)
        expect(indicators.indicators[:very_high_pressure].is_active).to eq(true)
      end
    end
  end

  describe ".new" do
    context "given an array of pressure data for a high and low pressure day" do
      it "generate and check pressure indicators" do
        pressure_values = [ 102100, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101170, 101160, 101050, 101040, 101030, 100950, 100920,
                            100900, 101290, 101280, 101270, 100860, 101250, 101240, 100730, 100700, 100620,
                            100600, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            100300, 100290, 100280, 100270, 100260, 100250, 101240, 101230, 101220, 99900
                          ]
        indicators = WrfForecast::Threshold::PressureThreshold.new(pressure_values)
        expect(indicators.indicators[:low_pressure].is_active).to eq(true)
        expect(indicators.indicators[:very_low_pressure].is_active).to eq(false)
        expect(indicators.indicators[:high_pressure].is_active).to eq(true)
        expect(indicators.indicators[:very_high_pressure].is_active).to eq(false)
      end
    end
  end
  

  describe ".new" do
    context "given an array of pressure data for a normal pressure day" do
      it "generate and check pressure indicators" do
        pressure_values = [ 101300, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101170, 101160, 101050, 101040, 101030, 100950, 100920,
                            100900, 101290, 101280, 101270, 100860, 101250, 101240, 100730, 100700, 100620,
                            100600, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220,
                            101200, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101200
                          ]
        indicators = WrfForecast::Threshold::PressureThreshold.new(pressure_values)
        expect(indicators.indicators[:low_pressure].is_active).to eq(false)
        expect(indicators.indicators[:very_low_pressure].is_active).to eq(false)
        expect(indicators.indicators[:high_pressure].is_active).to eq(false)
        expect(indicators.indicators[:very_high_pressure].is_active).to eq(false)
      end
    end
  end

  describe ".new" do
    context "given an array of temperature data with insuffient data" do
      it "try to generate the indicators and raise error" do
        expect {
          pressure_values = [ 101300, 101290, 101280, 101270, 101260, 101250, 101240, 101230, 101220, 101220 ]
          WrfForecast::Threshold::PressureThreshold.new(pressure_values)
        }.to raise_error(ArgumentError)
      end
    end
  end

end
