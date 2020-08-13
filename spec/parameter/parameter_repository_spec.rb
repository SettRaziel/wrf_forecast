#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-16 20:11:41
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-08-13 18:30:33

require 'spec_helper'
require 'wrf_forecast/parameter'

describe WrfForecast::Parameter::ParameterRepository do

  describe ".new" do
    context "given the one element date flag" do
      it "create the repository with the correct flags" do
        arguments = ['-d', '2020-06-29', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:date]).to eq('2020-06-29')
      end
    end
  end

  describe ".new" do
    context "given the one element date flag" do
      it "create the repository with the correct flags" do
        arguments = ['--date', '2021-06-29', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:date]).to eq('2021-06-29')
      end
    end
  end

  describe ".new" do
    context "given the one element period flag with only one argument" do
      it "create the repository with the correct flags" do
        arguments = ['-p', '29', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:period]).to eq('29')
      end
    end
  end

  describe ".new" do
    context "given the one element period flag with only one argument" do
      it "create the repository with the correct flags" do
        arguments = ['--period', '42', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:period]).to eq('42')
      end
    end
  end

  describe ".new" do
    context "given the default flag" do
      it "create the repository with the correct flags" do
        arguments = ['--default', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:date].to_s).to eq(Time.parse('00:00').to_s)
        expect(parameter_repository.parameters[:period]).to eq('24')
      end
    end
  end

  describe ".new" do
    context "given only the filename" do
      it "create the repository with the correct filename" do
        arguments = ['filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:file]).to eq('filename')
      end
    end
  end

  describe ".new" do
    context "given no arguments for the initialization" do
      it "raise an argument error" do
        arguments = [ ]
        expect { 
          WrfForecast::Parameter::ParameterRepository.new(arguments)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".new" do
    context "given an invalid parameter" do
      it "raise an argument error" do
        arguments = ['-1', 'filename']
        expect { 
          WrfForecast::Parameter::ParameterRepository.new(arguments)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".new" do
    context "given an invalid parameter" do
      it "raise an argument error" do
        arguments = ['--error', 'filename']
        expect { 
          WrfForecast::Parameter::ParameterRepository.new(arguments)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".new" do
    context "given the version flag as parameter" do
      it "set the flag for version output" do
        arguments = ['-v', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:version]).to eq(true)
      end
    end
  end

  describe ".new" do
    context "given the version flag as parameter" do
      it "set the flag for version output" do
        arguments = ['--version', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:version]).to eq(true)
      end
    end
  end

  describe ".new" do
    context "given the help flag as parameter" do
      it "set the flag for help output" do
        arguments = ['-h', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:help]).to eq(true)
      end
    end
  end

  describe ".new" do
    context "given the help flag with the date parameter" do
      it "set the flag for help output with the date" do
        arguments = ['-d', '-h', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:help]).to eq(:date)
      end
    end
  end

  describe ".new" do
    context "given the help flag with the date parameter" do
      it "set the flag for help output with the date" do
        arguments = ['--date', '--help', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:help]).to eq(:date)
      end
    end
  end

  describe ".new" do
    context "given the one element offset flag with only one argument" do
      it "create the repository with the correct flags" do
        arguments = ['-o', '12', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:offset]).to eq('12')
      end
    end
  end

  describe ".new" do
    context "given the one element offset flag with only one argument" do
      it "create the repository with the correct flags" do
        arguments = ['--offset', '12', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:offset]).to eq('12')
      end
    end
  end

  describe ".new" do
    context "given the warning flag" do
      it "create the repository with the correct flags" do
        arguments = ['-j', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:json]).to eq(true)
      end
    end
  end

  describe ".new" do
    context "given the warning flag" do
      it "create the repository with the correct flags" do
        arguments = ['--json', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:json]).to eq(true)
      end
    end
  end

  describe ".new" do
    context "given the warning flag" do
      it "create the repository with the correct flags" do
        arguments = ['-w', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:warning]).to eq(true)
      end
    end
  end

  describe ".new" do
    context "given the warning flag" do
      it "create the repository with the correct flags" do
        arguments = ['--warning', 'filename']
        parameter_repository = WrfForecast::Parameter::ParameterRepository.new(arguments)
        expect(parameter_repository.parameters[:warning]).to eq(true)
      end
    end
  end

end
