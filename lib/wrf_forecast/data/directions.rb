require "i18n"

module WrfForecast

  # Simple data class to map the geographical directions to a string representation
  class Directions

    # initialization
    def initialize
      initialize_directions
    end

    # encapsulating getter to retrieve the direction string to a given direction
    # @param [Symbol] symbol the symbol representing the direction
    # @return [String] the string representation of the direction
    def get_direction_string(symbol)
      @directions[symbol]
    end
  
    private

    # @return [Hash] the mapping of direction and direction name
    attr_reader :directions

    # method to initialize the mapping from direction to direction text
    def initialize_directions
      @directions = Hash.new()
      @directions[:N]  = I18n.t("direction.north")
      @directions[:S]  = I18n.t("direction.south")
      @directions[:W]  = I18n.t("direction.west")
      @directions[:E]  = I18n.t("direction.east")
      @directions[:NW] = I18n.t("direction.northwest")
      @directions[:NE] = I18n.t("direction.northeast")
      @directions[:SW] = I18n.t("direction.southwest")
      @directions[:SE] = I18n.t("direction.southeast")
      nil
    end
  end

end
