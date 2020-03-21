#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-20 21:08:30
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-21 20:19:58

require 'spec_helper'
require_relative '../../lib/main_module'

describe WrfForecast do

  describe "#initialize_parameter" do
    context "given an array of parameters" do
      it "initialize the handler and repositories correctly" do
        arguments = ['--default', File.join(__dir__,"../files/Ber_24.d01.TS")]
        WrfForecast.initialize_parameter(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters
        expect(parameters[:date]).to match(Time.parse('00:00').to_s)
        expect(parameters[:period]).to match('24')
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to match(1398)
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
        }.to output("wrf_forecast version 0.0.1".yellow + "\n" + \
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
