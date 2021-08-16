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

    # module method to determine the correct locale from a given string
    # @param [String] locale_string the desired locale in its short string representation
    def self.determine_locale(locale_string)
      case locale_string
        when "de" then change_locale(:de)
        when "en" then change_locale(:en)
      else
        puts "Warning: found no match for locale #{locale_string}."
      end
      nil
    end

  end

end
