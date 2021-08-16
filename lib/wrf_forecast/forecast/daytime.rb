require "i18n"

module WrfForecast

  # As part of the forecast text this module holds string replacements 
  # for the considered daytime
  # @todo not used at the moment
  module Daytime
    # @return [String] string representation for the morning
    MORNING = I18n.t("forecast_text.daytime.morning")
    # @return [String] string representation for the noon
    NOON = I18n.t("forecast_text.daytime.noon")
    # @return [String] string representation for the afternoon
    AFTERNOON = I18n.t("forecast_text.daytime.afternoon")
    # @return [String] string representation for the evening    
    EVENING = I18n.t("forecast_text.daytime.evening")
    # @return [String] string representation for the night
    NIGHT = I18n.t("forecast_text.daytime.night")
  end

end
