require "wrf_library/sun_equation"

module WrfForecast

  module Text

    # This class determines the time for sunrise and the sunset for a given location
    # and a given day. The time is formatted in a human readable time. With that this
    # class generates the text passage of the text forecast presenting these times
    class SuntimeText

      # @return [String] the part of the forcast text containing sunrise and sunset
      attr_reader :text

      # initialization
      # @param [WrfLibrary::WrfMetaData] meta_data the meta data of the given weather station
      def initialize(meta_data)
        coordinate = meta_data.station.coordinate
        @text = generate_sunrise_text(meta_data.start_date, coordinate).concat(", ")
        @text.concat(generate_sunset_text(meta_data.start_date, coordinate))
      end

      private

      # method to calculate the sunrise time and the text part for the sunrise
      # @param [Time] date the day for the calculation of the sunrise
      # @param [WrfLibrary::Coordinate] coordinate the location of the weather station
      # @return [String] the text part for the sunrise
      def generate_sunrise_text(date, coordinate)
        sunrise = WrfLibrary::SunEquation.calculate_sunrise_time(date, coordinate.x, coordinate.y)
        text = I18n.t("forecast_text.suntime.sunrise")
        text.concat(format_time(sunrise))
      end

      # method to calculate the sunset time and the text part for the sunset
      # @param [Time] date the day for the calculation of the sunset
      # @param [WrfLibrary::Coordinate] coordinate the location of the weather station
      # @return [String] the text part for the sunset
      def generate_sunset_text(date, coordinate)
        sunset = WrfLibrary::SunEquation.calculate_sunset_time(date, coordinate.x, coordinate.y)
        text = I18n.t("forecast_text.suntime.sunset")
        text.concat(format_time(sunset))
      end

      # helper method to format the time from a Float to a timestamp with hh:mm
      # @param [Float] time the given time as a decimal number
      # @param [String] the formatted, human readable timestamp
      def format_time(time)
        hours = time.floor
        text = ""
        text.concat("0") if (hours < 10)
        text.concat("#{hours}").concat(":")
        minutes = (time.round(2) % 1 * 60).round(0)
        text.concat("0") if (minutes < 10)
        text.concat("#{minutes}")
      end

    end

  end

end
