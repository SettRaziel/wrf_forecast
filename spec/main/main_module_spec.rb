#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-20 21:08:30
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-27 16:13:37

require 'spec_helper'
require 'wrf_forecast'

describe WrfForecast do

  describe "#initialize_parameter" do
    context "given an array of parameters" do
      it "initialize the parameters correctly" do
        arguments = ['--default', File.join(__dir__,"../files/Ber_24.d01.TS")]
        WrfForecast.initialize_parameter(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters
        expect(parameters[:date]).to eq(Time.parse('00:00').to_s)
        expect(parameters[:period]).to eq('24')
      end
    end
  end

  describe "#initialize_parameter" do
    context "given an array of parameters" do
      it "initialize the handler and repositories correctly, create output" do
        arguments = ['--default', File.join(__dir__,"../files/Ber_24.d01.TS")]
        WrfForecast.initialize_parameter(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters

        timestamp = Time.parse('00:00').to_s
        expected = "Weather forecast of Berlin for the #{timestamp}.\n\n"
        expected.concat('Today will be a cold day.')
        expected.concat(' The maximum temperature will reach up to 10 degrees celsius.')
        expected.concat(" The minimum temperature will be -4 degrees celsius.\n")
        expected.concat('The wind will be normal and will reach up to ')
        expected.concat("23 km/h from west. The mean wind will be 16 km/h.\n")
        expected.concat("The forecast does not predict rain.")
        expect(WrfForecast.output_forecast).to eq(expected)
        expect(parameters[:date]).to eq(timestamp)
        expect(parameters[:period]).to eq('24')
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(994)
        expect(WrfForecast.forecast_handler).to be_truthy
      end
    end
  end

  describe "#initialize_parameter" do
    context "given an array of parameters" do
      it "initialize the handler and repositories correctly, create output" do
        timestamp = Time.parse('00:00').to_s
        arguments = ['-d', timestamp, File.join(__dir__,"../files/Ber_24.d01.TS")]
        WrfForecast.initialize_parameter(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters

        expected = "Weather forecast of Berlin for the #{timestamp}.\n\n"
        expected.concat('Today will be a cold day.')
        expected.concat(' The maximum temperature will reach up to 10 degrees celsius.')
        expected.concat(" The minimum temperature will be -4 degrees celsius.\n")
        expected.concat('The wind will be normal and will reach up to ')
        expected.concat("23 km/h from west. The mean wind will be 16 km/h.\n")
        expected.concat("The forecast does not predict rain.")
        expect(WrfForecast.output_forecast).to eq(expected)
        expect(parameters[:date]).to eq(timestamp)
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(994)
        expect(WrfForecast.forecast_handler).to be_truthy
      end
    end
  end

  describe "#initialize_parameter" do
    context "given an array of parameters" do
      it "initialize the handler and repositories correctly, create output" do
        arguments = ['--default', File.join(__dir__,"../files/Ber.d01.TS")]
        WrfForecast.initialize_parameter(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters

        timestamp = Time.parse('00:00').to_s
        expected = "Weather forecast of Berlin for the #{timestamp}.\n\n"
        expected.concat('Today will be a normal day.')
        expected.concat(' The maximum temperature will reach up to 10 degrees celsius.')
        expected.concat(" The minimum temperature will be 1 degrees celsius.\n")
        expected.concat('The wind will be normal and will reach up to ')
        expected.concat("17 km/h from northeast. The mean wind will be 11 km/h.\n")
        expected.concat('The forecast does predict normal rain with a maximum of ')
        expected.concat("0.3 mm in 1 hour and some dry periods during the day.")
        expect(WrfForecast.output_forecast).to eq(expected)
        expect(parameters[:date]).to eq(timestamp)
        expect(parameters[:period]).to eq('24')
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(1124)
        expect(WrfForecast.forecast_handler).to be_truthy
      end
    end
  end

  describe "#initialize_parameter" do
    context "given an array of parameters" do
      it "initialize the handler and repositories correctly, create output" do
        arguments = ['--default', '-o', '6', File.join(__dir__,"../files/Ber.d01.TS")]
        WrfForecast.initialize_parameter(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters

        timestamp = Time.parse('00:00').to_s
        expected = "Weather forecast of Berlin for the #{timestamp}.\n\n"
        expected.concat('Today will be a cold day.')
        expected.concat(' The maximum temperature will reach up to 10 degrees celsius.')
        expected.concat(" The minimum temperature will be -1 degrees celsius.\n")
        expected.concat('The wind will be normal and will reach up to ')
        expected.concat("19 km/h from northeast. The mean wind will be 12 km/h.\n")
        expected.concat('The forecast does predict normal rain with a maximum of ')
        expected.concat("0.3 mm in 1 hour and some dry periods during the day.")
        expect(WrfForecast.output_forecast).to eq(expected)
        expect(parameters[:date]).to eq(timestamp)
        expect(parameters[:period]).to eq('24')
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(1009)
        expect(WrfForecast.forecast_handler).to be_truthy
      end
    end
  end

  describe "#initialize_parameter" do
    context "given an array of parameters" do
      it "initialize the handler and repositories correctly, create output" do
        arguments = ['--default', '-o', '24', File.join(__dir__,"../files/Ber.d01.TS")]
        WrfForecast.initialize_parameter(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters

        timestamp = Time.parse('00:00').to_s
        expected = "Weather forecast of Berlin for the #{timestamp}.\n\n"
        expected.concat('Today will be a cold day.')
        expected.concat(' The maximum temperature will reach up to 7 degrees celsius.')
        expected.concat(" The minimum temperature will be -2 degrees celsius.\n")
        expected.concat('The wind will be normal and will reach up to ')
        expected.concat("27 km/h from northeast. The mean wind will be 21 km/h.\n")
        expected.concat("The forecast does not predict rain.")
        expect(WrfForecast.output_forecast).to eq(expected)
        expect(parameters[:date]).to eq(timestamp)
        expect(parameters[:period]).to eq('24')
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(923)
        expect(WrfForecast.forecast_handler).to be_truthy
      end
    end
  end

  describe "#print_help_for" do
    context "given an array of parameters" do
      it "print the help text for :default" do
        expect { 
          arguments = ['--default', '-h', File.join(__dir__,"../files/Ber_24.d01.TS")]
          WrfForecast.initialize_parameter(arguments)
          WrfForecast.print_help
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    "     --default  ".light_blue +  \
                    "runs the script with date as today at midnight and a 24 h forecast period\n").to_stdout
      end
    end
  end

  describe "#print_version" do
    context "given an error message text" do
      it "print the error message text" do
        expect {
          WrfForecast.print_version
        }.to output("wrf_forecast version 0.1.3".yellow + "\n" + \
                    "Created by Benjamin Held (March 2019)".yellow + "\n").to_stdout
      end
    end
  end

  describe "#print_error" do
    context "given an error message text" do
      it "print the error message text" do
        expect {
          WrfForecast.print_error("error message")
        }.to output("error message".red + "\n" + \
                    "For help type: ruby <script> --help".green + "\n").to_stdout
      end
    end
  end

end
