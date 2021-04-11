require "i18n"

module WrfForecast

  # This module loads and regulates the locale settings that are used to create the forecast
  module LocaleConfiguration

    # module method to load the locale files from the given path
    # @param [String] locale_path the directory with the locale files
    def self.initialize_locale(locale_path)
      I18n.load_path << Dir[File.expand_path(locale_path) + "/*.yml"]
      I18n.default_locale = :en
      nil
    end

    # module method to change the locale
    # @param [Symbol] locale the given locale symbol
    def self.change_locale(locale)
      I18n.locale = locale
      nil
    end

  end

end
