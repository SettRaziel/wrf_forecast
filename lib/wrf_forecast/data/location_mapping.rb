# @Author: Benjamin Held
# @Date:   2019-06-28 16:45:16
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-06-06 10:11:36

require "ruby_utils/file_reader"
require "ruby_utils/string"

module WrfForecast

  # @todo not used at the moment
  module Location

    # Simple data class to store a hash mapping from a location key to a location name
    # The csv formatted input file need to contain key;location pairs for each entry
    # @todo this class is only used in tests at the moment
    class LocationMapping

      # initialization
      # @param [String] location_file the filepath to the location file
      def initialize(location_file)
        @locations = Hash.new()
        create_mapping(location_file)
      end

      # method to return the location name to a given key
      # @return [String] returns the location name if found, else nil
      def get_file_to_location(location_shortcut)
        @locations.fetch(location_shortcut, nil)
      end

      private

      # @return [Hash] the mapping of location key and location name
      attr :locations

      # method to read the mapping file and generate the hash mapping for the locations
      # @param [String] location_file the filepath to the location file
      def create_mapping(location_file)
        data = RubyUtils::FileReader.new(location_file, ";").data
        data.each { |line|
          if (line.length == 2 && line[0] != nil && line[1] != nil)
            @locations[line[0]] = line[1]
          else
            raise ArgumentError, "Error: Location file contains invalid location pair".red
          end
        }
        nil
      end

    end

  end

end
