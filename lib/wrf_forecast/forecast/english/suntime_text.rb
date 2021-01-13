#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2021-01-12 22:07:19
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-01-13 20:14:58

require "wrf_library/sun_equation"

module WrfForecast

  module Text

    class SuntimeText

      attr_reader :text

      def initialize(meta_data)
        coordinate = meta_data.station.coordinate
        @text = generate_sunrise_text(meta_data.start_date, coordinate).concat(", ")
        @text.concat(generate_sunset_text(meta_data.start_date, coordinate))
      end

      private

      def generate_sunrise_text(date, coordinate)
        sunrise = WrfLibrary::SunEquation.calculate_sunrise_time(date, coordinate.x, coordinate.y)
        text = "Sunrise: "
        text.concat(format_time(sunrise))
      end

      def generate_sunset_text(date, coordinate)
        sunset = WrfLibrary::SunEquation.calculate_sunset_time(date, coordinate.x, coordinate.y)
        text = "Sunset: "
        text.concat(format_time(sunset))
      end

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
