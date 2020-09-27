# @Author: Benjamin Held
# @Date:   2019-05-07 10:03:48
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-09-27 20:40:04

require "ruby_utils/help_output"

module WrfForecast

  # Output class for help text
  class HelpOutput < RubyUtils::BasicHelpOutput

    private

    # method to specify and add the help entries with help text only
    def self.add_single_help_entries
      add_simple_text(:default, "     --default  ", 
            "runs the script with date as today at midnight and a 24 h forecast period")
      add_simple_text(:json, " -j, --json  ", 
            "returns the forecast values not as a text but a json object")
      nil
    end

    # method to specify and add the help entries with help text and one argument
    def self.add_one_argument_help_entries
      add_single_argument_text(:date, " -d, --date     ", " <date>",
            "; specifies the start_date of the requested forecast")
      add_single_argument_text(:offset, " -o, --offset   ", " <offset>",
            "; specifies how many hours from the forecast should be skipped")
      add_single_argument_text(:period, " -p, --period   ", " <period>",
            "; specifies the forecast period")
      add_single_argument_text(:save, " -s, --save     ", " <target>",
            "; specifies the output file where the results are saved")
      nil
    end

    # method to specify and add the help entries with help text and two arguments
    def self.add_two_argument_help_entries
      nil
    end

    # method to print the header of the help output
    def self.print_help_head
      puts "script usage:".red + " ruby <script> [parameters] <filename>"
      puts "help usage :".green + "              ruby <script> (-h | --help)"
      puts "help usage for parameter:".green +
           " ruby <script> <parameter> (-h | --help)"
      puts "#{get_script_name} help:".light_yellow
    end

    # method to print the invalid parameter combinations
    def self.print_invalid_combinations
      nil
    end

    # method to print the available configuration parameter
    def self.print_configuration_parameter
      nil
    end

      # method to set the name of the script project
    def self.get_script_name
      "WRF forecast"
    end
    
  end

end
