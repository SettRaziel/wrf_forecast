# @Author: Benjamin Held
# @Date:   2019-05-07 10:03:48
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-05-07 10:05:31
require_relative '../wrf_library/ruby_utils/help/help_output'

# Output class for help text
class HelpOutput < BasicHelpOutput

  private

  # method to specify and add the help entries with help text only
  def self.add_single_help_entries
    nil
  end

  # method to specify and add the help entries with help text and one argument
  def self.add_one_argument_help_entries
    add_single_argument_text(:date, ' -d, --date     ', ' <date>',
          '; specifies the start_date of the requested forecast ')
    nil
  end

  # method to specify and add the help entries with help text and two arguments
  def self.add_two_argument_help_entries
    nil
  end

  def self.print_help_head
    puts 'script usage:'.red + ' ruby <script> [parameters] <filename>'
    puts 'help usage :'.green + '              ruby <script> (-h | --help)'
    puts 'help usage for parameter:'.green +
         ' ruby <script> <parameter> (-h | --help)'
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
      'WRF forecast'
  end
  
end
