# @Author: Benjamin Held
# @Date:   2019-06-28 16:45:16
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-07-12 19:12:54

module Location

  require_relative '../wrf_library/ruby_utils/data/file_reader'
  require_relative '../wrf_library/ruby_utils/string/string'

  class LocationMapping

    def initialize(location_file)
      @locations = Hash.new()
      create_mapping(location_file)
    end

    def get_file_to_location(location_shortcut)
      @locations.fetch(location_shortcut)
    end

    private

    attr :locations

    def create_mapping(location_file)
      data = FileReader.new(location_file, ';').data
      data.each { |line|
        puts line.inspect
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
