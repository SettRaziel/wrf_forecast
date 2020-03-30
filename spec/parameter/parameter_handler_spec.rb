#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-17 17:19:08
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-20 16:42:48

require 'spec_helper'
require_relative '../../lib/parameter'

describe Parameter::ParameterHandler do

  describe ".new" do
    context "given the date flag" do
      it "create the repository and pass the parameter contrains" do
        arguments = ['-d', '2020-06-29', 'filename']
        parameter_handler = Parameter::ParameterHandler.new(arguments)
        expect(parameter_handler.repository.parameters[:date]).to match('2020-06-29')
      end
    end
  end

  describe ".new" do
    context "given the interval and compare flag" do
      it "create the repository and fail the parameter contrains" do
        arguments = ['-p', '42', 'filename']
        expect {
          Parameter::ParameterHandler.new(arguments)
        }.to raise_error(ArgumentError)
      end
    end
  end

end
