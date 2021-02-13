#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-17 17:19:08
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-02-10 20:24:29

require "spec_helper"
require "wrf_forecast/parameter"

describe WrfForecast::Parameter::ParameterHandler do

  describe ".new" do
    context "given the date flag" do
      it "create the repository and pass the parameter contrains" do
        arguments = ["-d", "2020-06-29", "--file", "filename"]
        parameter_handler = WrfForecast::Parameter::ParameterHandler.new(arguments)
        expect(parameter_handler.repository.parameters[:date]).to eq("2020-06-29")
      end
    end
  end

  describe ".new" do
    context "given the period flag" do
      it "create the repository and fail the parameter contrains due to missing date" do
        arguments = ["-p", "42", "-f", "filename"]
        expect {
          WrfForecast::Parameter::ParameterHandler.new(arguments)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".new" do
    context "given the date and offset flag" do
      it "create the repository and fail the parameter contrains due to missing period requirement" do
        arguments = ["-d", "2020-06-29", "-o", "12", "--file", "filename"]
        expect {
          WrfForecast::Parameter::ParameterHandler.new(arguments)
        }.to raise_error(ArgumentError)
      end
    end
  end

end
