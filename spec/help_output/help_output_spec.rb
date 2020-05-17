#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-16 20:59:23
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-05-10 16:48:55

require 'spec_helper'
require 'wrf_forecast/help/help_output'

describe WrfForecast::HelpOutput do

  describe "#print_help_for" do
    context "given a simple help entry" do
      it "print the help text for :default" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(:default) 
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    "     --default  ".light_blue +  \
                    "runs the script with date as today at midnight and a 24 h forecast period\n").to_stdout
      end
    end
  end

  describe "#print_help_for" do
    context "given a simple help entry" do
      it "print the help text for :warning" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(:warning) 
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    " -w, --warning  ".light_blue +  \
                    "adds an additional text section containing warnings and significant weather\n").to_stdout
      end
    end
  end

  describe "#print_help_for" do
    context "given a one element help entry" do
      it "print the help text for :period" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(:period) 
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    " -p, --period   ".light_blue + "argument:".red + " <period>".yellow  + \
                    "; specifies the forecast period\n").to_stdout
      end
    end
  end

  describe "#print_help_for" do
    context "given a one element help entry" do
      it "print the help text for :date" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(:date) 
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    " -d, --date     ".light_blue + "argument:".red + " <date>".yellow  + \
                    "; specifies the start_date of the requested forecast\n").to_stdout
      end
    end
  end

  describe "#print_help_for" do
    context "given a one element help entry" do
      it "print the help text for :offset" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(:offset) 
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    " -o, --offset   ".light_blue + "argument:".red + " <offset>".yellow  + \
                    "; specifies how many hours from the forecast should be skipped\n").to_stdout
      end
    end
  end

  describe "#print_help_for" do
    context "given a to whole help text" do
      it "print the help text for the script" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(true)
        }.to output("script usage:".red + " ruby <script> [parameters] <filename>\n" + \
                    "help usage :".green + "              ruby <script> (-h | --help)\n" + \
                    "help usage for parameter:".green + " ruby <script> <parameter> (-h | --help)\n" + \
                    "WRF forecast help:".light_yellow + "\n" + \
                    " -h, --help     ".light_blue + "show help text\n" + \
                    " -v, --version  ".light_blue + "prints the current version of the project\n" + \
                    "     --default  ".light_blue +  \
                    "runs the script with date as today at midnight and a 24 h forecast period\n" + \
                    " -w, --warning  ".light_blue +  \
                    "adds an additional text section containing warnings and significant weather\n" + \
                    " -d, --date     ".light_blue + "argument:".red + " <date>".yellow  + \
                    "; specifies the start_date of the requested forecast\n" + \
                    " -o, --offset   ".light_blue + "argument:".red + " <offset>".yellow  + \
                    "; specifies how many hours from the forecast should be skipped\n" + \
                    " -p, --period   ".light_blue + "argument:".red + " <period>".yellow  + \
                    "; specifies the forecast period\n").to_stdout
      end
    end
  end  

end
