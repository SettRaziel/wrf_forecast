#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-20 21:08:30
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-02-16 18:28:22

require "spec_helper"
require "time"
require "wrf_forecast"

describe WrfForecast do

  describe "#output_forecast" do
    context "given an array of parameters with default option" do
      it "initialize the parameters correctly" do
        arguments = ["--default", "--file", File.join(__dir__,"../files/Ber_24.d01.TS")]
        WrfForecast.initialize(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters
        expect(parameters[:date]).to eq(Time.parse("00:00").to_s)
        expect(parameters[:period]).to eq("24")
      end
    end
  end

  describe "#output_forecast" do
    context "given an array of parameters with default option" do
      it "initialize the handler and repositories correctly, create output" do
        arguments = ["--default", "-f", File.join(__dir__,"../files/Ber_24.d01.TS")]
        WrfForecast.initialize(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters
        suntime = WrfForecast::Text::SuntimeText.new(WrfForecast.wrf_handler.data_repository.meta_data)

        timestamp = Time.parse("00:00").to_s
        expected = "Weather forecast of Berlin for the #{timestamp}.\n\n"
        expected.concat(suntime.text).concat("\n")
        expected.concat("Today will be a cold day.")
        expected.concat(" The maximum temperature will reach up to 10 degrees celsius.")
        expected.concat(" The minimum temperature will be -4 degrees celsius.\n")
        expected.concat("The wind will be normal and will reach up to ")
        expected.concat("23 km/h from west. The mean wind will be 16 km/h.\n")
        expected.concat("The forecast does not predict rain.\n\n")
        expected.concat("Warnings: \n")
        expected.concat("frost day (temperature will fall below 0 degrees celsius)")
        expect(WrfForecast.output_forecast).to eq(expected)
        expect(parameters[:date]).to eq(timestamp)
        expect(parameters[:period]).to eq("24")
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(994)
        expect(WrfForecast.forecast_handler).to be_truthy
      end
    end
  end

  describe "#output_forecast" do
    context "given an array of parameters with timestamp values" do
      it "initialize the handler and repositories correctly, create output" do
        timestamp = Time.parse("00:00").to_s
        arguments = ["-d", timestamp, "--file", File.join(__dir__,"../files/Ber_24.d01.TS")]
        WrfForecast.initialize(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters
        suntime = WrfForecast::Text::SuntimeText.new(WrfForecast.wrf_handler.data_repository.meta_data)

        expected = "Weather forecast of Berlin for the #{timestamp}.\n\n"
        expected.concat(suntime.text).concat("\n")
        expected.concat("Today will be a cold day.")
        expected.concat(" The maximum temperature will reach up to 10 degrees celsius.")
        expected.concat(" The minimum temperature will be -4 degrees celsius.\n")
        expected.concat("The wind will be normal and will reach up to ")
        expected.concat("23 km/h from west. The mean wind will be 16 km/h.\n")
        expected.concat("The forecast does not predict rain.\n\n")
        expected.concat("Warnings: \n")
        expected.concat("frost day (temperature will fall below 0 degrees celsius)")
        expect(WrfForecast.output_forecast).to eq(expected)
        expect(parameters[:date]).to eq(timestamp)
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(994)
        expect(WrfForecast.forecast_handler).to be_truthy
      end
    end
  end

  describe "#output_forecast" do
    context "given an array of parameters with default values" do
      it "initialize the handler and repositories correctly, create output" do
        arguments = ["--default", "-f", File.join(__dir__,"../files/Ber.d01.TS")]
        WrfForecast.initialize(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters
        suntime = WrfForecast::Text::SuntimeText.new(WrfForecast.wrf_handler.data_repository.meta_data)

        timestamp = Time.parse("00:00").to_s
        expected = "Weather forecast of Berlin for the #{timestamp}.\n\n"
        expected.concat(suntime.text).concat("\n")
        expected.concat("Today will be a normal day.")
        expected.concat(" The maximum temperature will reach up to 10 degrees celsius.")
        expected.concat(" The minimum temperature will be 1 degrees celsius.\n")
        expected.concat("The wind will be normal and will reach up to ")
        expected.concat("17 km/h from northeast. The mean wind will be 11 km/h.\n")
        expected.concat("The forecast does predict normal rain with a maximum of ")
        expected.concat("0.3 mm in 1 hour and up to 1 mm for the day.")
        expected.concat(" There are some dry periods during the day.\n\n")
        expected.concat("Warnings: -")
        expect(WrfForecast.output_forecast).to eq(expected)
        expect(parameters[:date]).to eq(timestamp)
        expect(parameters[:period]).to eq("24")
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(1124)
        expect(WrfForecast.forecast_handler).to be_truthy
      end
    end
  end

  describe "#output_forecast" do
    context "given an array of parameters with default values and offset flag" do
      it "initialize the handler and repositories correctly, create output" do
        arguments = ["--default", "-o", "6", "--file", File.join(__dir__,"../files/Ber.d01.TS")]
        WrfForecast.initialize(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters
        suntime = WrfForecast::Text::SuntimeText.new(WrfForecast.wrf_handler.data_repository.meta_data)

        timestamp = Time.parse("00:00").to_s
        expected = "Weather forecast of Berlin for the #{timestamp}.\n\n"
        expected.concat(suntime.text).concat("\n")
        expected.concat("Today will be a cold day.")
        expected.concat(" The maximum temperature will reach up to 10 degrees celsius.")
        expected.concat(" The minimum temperature will be -1 degrees celsius.\n")
        expected.concat("The wind will be normal and will reach up to ")
        expected.concat("19 km/h from northeast. The mean wind will be 12 km/h.\n")
        expected.concat("The forecast does predict normal rain with a maximum of ")
        expected.concat("0.3 mm in 1 hour and up to 1 mm for the day.")
        expected.concat(" There are some dry periods during the day.\n\n")
        expected.concat("Warnings: \n")
        expected.concat("frost day (temperature will fall below 0 degrees celsius)")
        expect(WrfForecast.output_forecast).to eq(expected)
        expect(parameters[:date]).to eq(timestamp)
        expect(parameters[:period]).to eq("24")
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(1009)
        expect(WrfForecast.forecast_handler).to be_truthy
      end
    end
  end

  describe "#output_forecast" do
    context "given an array of parameters with default values and offset" do
      it "initialize the handler and repositories correctly, create output" do
        arguments = ["--default", "-o", "24", "-f", File.join(__dir__,"../files/Ber.d01.TS")]
        WrfForecast.initialize(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters
        suntime = WrfForecast::Text::SuntimeText.new(WrfForecast.wrf_handler.data_repository.meta_data)

        timestamp = Time.parse("00:00").to_s
        expected = "Weather forecast of Berlin for the #{timestamp}.\n\n"
        expected.concat(suntime.text).concat("\n")
        expected.concat("Today will be a cold day.")
        expected.concat(" The maximum temperature will reach up to 7 degrees celsius.")
        expected.concat(" The minimum temperature will be -2 degrees celsius.\n")
        expected.concat("The wind will be normal and will reach up to ")
        expected.concat("27 km/h from northeast. The mean wind will be 21 km/h.\n")
        expected.concat("The forecast does not predict rain.\n\n")
        expected.concat("Warnings: \n")
        expected.concat("frost day (temperature will fall below 0 degrees celsius)")
        expect(WrfForecast.output_forecast).to eq(expected)
        expect(parameters[:date]).to eq(timestamp)
        expect(parameters[:period]).to eq("24")
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(923)
        expect(WrfForecast.forecast_handler).to be_truthy
      end
    end
  end

  describe "#output_forecast" do
    context "given an array of parameters with timestamp flag" do
      it "initialize the handler and repositories correctly, create output" do
        timestamp = Time.parse("00:00").to_s
        arguments = ["-d", timestamp, "--file", File.join(__dir__,"../files/Ber_24.d01.TS")]
        WrfForecast.initialize(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters
        suntime = WrfForecast::Text::SuntimeText.new(WrfForecast.wrf_handler.data_repository.meta_data)

        expected = "Weather forecast of Berlin for the #{timestamp}.\n\n"
        expected.concat(suntime.text).concat("\n")
        expected.concat("Today will be a cold day.")
        expected.concat(" The maximum temperature will reach up to 10 degrees celsius.")
        expected.concat(" The minimum temperature will be -4 degrees celsius.\n")
        expected.concat("The wind will be normal and will reach up to ")
        expected.concat("23 km/h from west. The mean wind will be 16 km/h.\n")
        expected.concat("The forecast does not predict rain.\n\n")
        expected.concat("Warnings: \n")
        expected.concat("frost day (temperature will fall below 0 degrees celsius)")
        expect(WrfForecast.output_forecast).to eq(expected)
        expect(parameters[:date]).to eq(timestamp)
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(994)
        expect(WrfForecast.forecast_handler).to be_truthy
      end
    end
  end

  describe "#output_forecast" do
    context "given an array of parameters with default values" do
      it "initialize the handler and repositories correctly, create output" do
        arguments = ["--default", "-f", File.join(__dir__,"../files/Ber.d01.TS")]
        WrfForecast.initialize(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters
        suntime = WrfForecast::Text::SuntimeText.new(WrfForecast.wrf_handler.data_repository.meta_data)

        timestamp = Time.parse("00:00").to_s
        expected = "Weather forecast of Berlin for the #{timestamp}.\n\n"
        expected.concat(suntime.text).concat("\n")
        expected.concat("Today will be a normal day.")
        expected.concat(" The maximum temperature will reach up to 10 degrees celsius.")
        expected.concat(" The minimum temperature will be 1 degrees celsius.\n")
        expected.concat("The wind will be normal and will reach up to ")
        expected.concat("17 km/h from northeast. The mean wind will be 11 km/h.\n")
        expected.concat("The forecast does predict normal rain with a maximum of ")
        expected.concat("0.3 mm in 1 hour and up to 1 mm for the day.")
        expected.concat(" There are some dry periods during the day.\n\n")
        expected.concat("Warnings: -")
        expect(WrfForecast.output_forecast).to eq(expected)
        expect(parameters[:date]).to eq(timestamp)
        expect(parameters[:period]).to eq("24")
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(1124)
        expect(WrfForecast.forecast_handler).to be_truthy
      end
    end
  end

  describe "#output_forecast" do
    context "given an array of parameters with default values and json flag" do
      it "initialize the handler and repositories correctly, create output" do
        timestamp = "2020-06-29 00:00:00 +0200"
        arguments = ["-d", timestamp, "-p", "24", "-j", "--file", File.join(__dir__,"../files/Ber_24.d01.TS")]
        WrfForecast.initialize(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters

        expected = File.read(File.join(__dir__,"../files/expected_output.json"))
        expect(WrfForecast.output_forecast).to eq(expected)
        expect(parameters[:date]).to eq(timestamp)
        expect(parameters[:period]).to eq("24")
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(994)
        expect(WrfForecast.forecast_handler).to be_truthy
      end
    end
  end

  describe "#output_forecast" do
    context "given an array of parameters with default values, json flag and save option" do
      it "initialize the handler and repositories correctly, create and save output" do
        timestamp = "2020-06-29 00:00:00 +0200"
        output_file = File.join(__dir__,"output.json")
        arguments = ["-d", timestamp, "-p", "24", "-s", output_file, "-f", "-j", File.join(__dir__,"../files/Ber_24.d01.TS")]
        WrfForecast.initialize(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters

        expect(parameters[:save]).to eq(output_file)
        expected = File.read(File.join(__dir__,"../files/expected_output.json"))
        expect(WrfForecast.output_forecast).to eq(expected)
        expect(FileUtils.compare_file(output_file, File.join(__dir__,"../files/expected_output.json"))).to be_truthy
        expect(parameters[:date]).to eq(timestamp)
        expect(parameters[:period]).to eq("24")
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(994)
        expect(WrfForecast.forecast_handler).to be_truthy

        # clean up data from the test and catch errors since they should not let the test fail
        File.delete(output_file)
      end
    end
  end

  describe "#output_forecast" do
    context "given an array of parameters with default values and save option" do
      it "initialize the handler and repositories correctly, create output" do
        output_file = File.join(__dir__,"output")
        arguments = ["--default", "-s", output_file, "--file", File.join(__dir__,"../files/Ber_24.d01.TS")]
        WrfForecast.initialize(arguments)
        parameters = WrfForecast.parameter_handler.repository.parameters
        suntime = WrfForecast::Text::SuntimeText.new(WrfForecast.wrf_handler.data_repository.meta_data)

        timestamp = Time.parse("00:00").to_s
        WrfForecast.output_forecast
        expected = "Weather forecast of Berlin for the #{timestamp}.\n\n"
        expected.concat(suntime.text).concat("\n")
        expected.concat("Today will be a cold day.")
        expected.concat(" The maximum temperature will reach up to 10 degrees celsius.")
        expected.concat(" The minimum temperature will be -4 degrees celsius.\n")
        expected.concat("The wind will be normal and will reach up to ")
        expected.concat("23 km/h from west. The mean wind will be 16 km/h.\n")
        expected.concat("The forecast does not predict rain.\n\n")
        expected.concat("Warnings: \n")
        expected.concat("frost day (temperature will fall below 0 degrees celsius)")
        expect(File.read(output_file)).to eq(expected)
        expect(parameters[:date]).to eq(timestamp)
        expect(parameters[:period]).to eq("24")
        expect(WrfForecast.wrf_handler.data_repository.repository.size).to eq(994)
        expect(WrfForecast.forecast_handler).to be_truthy

        # clean up data from the test and catch errors since they should not let the test fail
        File.delete(output_file)

      end
    end
  end

  describe "#save_forecast" do
    context "given nil as a parameter for save_forecast" do
      it "print the error message" do
        expect {
          arguments = ["--default", "-s", "no_file", "-f", File.join(__dir__,"../files/Ber_24.d01.TS")]
          WrfForecast.initialize(arguments)
          WrfForecast.save_forecast(nil)
        }.to output("Error: No output was generated or it is nil.".red + "\n" + \
                    "For help type: ruby <script> --help".green + "\n").to_stdout
      end
    end
  end

  describe "#output_forecast" do
    context "given an array with version option" do
      it "initialize the handler and repositories correctly, check for no warnings" do
        expect {
          WrfForecast.initialize(["--version"])
          WrfForecast.output_forecast
        }.to output("Error: Module not initialized. Run WrfForecast.new(ARGV)".red + "\n" + \
                    "For help type: ruby <script> --help".green + "\n").to_stdout
      end
    end
  end

  describe "#get_warnings" do
    context "given an array of parameters with timestamp and warnings" do
      it "initialize the handler and repositories correctly, check warnings" do
        timestamp = Time.parse("00:00").to_s
        arguments = ["-d", timestamp, "--file", File.join(__dir__,"../files/Ber_24.d01.TS")]
        WrfForecast.initialize(arguments)
        warnings = WrfForecast.get_warnings
        expect(warnings[:air_temperature].size).to eq(1)
        expected = "frost day (temperature will fall below 0 degrees celsius)"
        expect(warnings[:air_temperature][0].warning_text).to eq(expected)
        expect(warnings[:wind_speed]).to be_empty
        expect(warnings[:rain]).to be_empty
      end
    end
  end

  describe "#get_warnings" do
    context "given an array with help option" do
      it "initialize application, check for error message" do
        expect {
          WrfForecast.initialize(["--help"])
          WrfForecast.get_warnings
        }.to output("Error: Module not initialized. Run WrfForecast.new(ARGV)".red + "\n" + \
                    "For help type: ruby <script> --help".green + "\n").to_stdout
      end
    end
  end

  describe "#get_warnings" do
    context "given an array of parameters with default option" do
      it "initialize the handler and repositories correctly, check for no warnings" do
        arguments = ["--default", "-f", File.join(__dir__,"../files/Ber.d01.TS")]
        WrfForecast.initialize(arguments)
        warnings = WrfForecast.get_warnings
        expect(warnings[:air_temperature]).to be_empty
        expect(warnings[:wind_speed]).to be_empty
        expect(warnings[:rain]).to be_empty
      end
    end
  end

  describe "#print_help" do
    context "given only the help parameter as an argument" do
      it "initialize application correctly and print help text" do
        expect { 
          arguments = ["--help"]
          WrfForecast.initialize(arguments)
          WrfForecast.print_help
        }.to output("script usage:".red + " ruby <script> [parameters] <filename>\n" + \
                    "help usage :".green + "              ruby <script> (-h | --help)\n" + \
                    "help usage for parameter:".green + " ruby <script> <parameter> (-h | --help)\n" + \
                    "WRF forecast help:".light_yellow + "\n" + \
                    " -h, --help     ".light_blue + "show help text\n" + \
                    " -v, --version  ".light_blue + "prints the current version of the project\n" + \
                    " -f, --file     ".light_blue + "argument:".red + " <file>".yellow + \
                    "; optional parameter that indicates a filepath to a readable file\n" + \
                    "     --default  ".light_blue +  \
                    "runs the script with date as today at midnight and a 24 h forecast period\n" + \
                    " -j, --json     ".light_blue +  \
                    "returns the forecast values not as a text but a json object\n" + \
                    " -d, --date     ".light_blue + "argument:".red + " <date>".yellow  + \
                    "; specifies the start_date of the requested forecast\n" + \
                    " -o, --offset   ".light_blue + "argument:".red + " <offset>".yellow  + \
                    "; specifies how many hours from the forecast should be skipped\n" + \
                    " -p, --period   ".light_blue + "argument:".red + " <period>".yellow  + \
                    "; specifies the forecast period\n" + \
                    " -s, --save     ".light_blue + "argument:".red + " <target>".yellow  + \
                    "; specifies the output file where the results are saved\n").to_stdout
      end
    end
  end

  describe "#print_help_for" do
    context "given an array of parameters" do
      it "print the help text for :default" do
        expect { 
          arguments = ["--default", "-h", File.join(__dir__,"../files/Ber_24.d01.TS")]
          WrfForecast.initialize(arguments)
          WrfForecast.print_help
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    "     --default  ".light_blue +  \
                    "runs the script with date as today at midnight and a 24 h forecast period\n").to_stdout
      end
    end
  end

  describe "#print_help_for" do
    context "given an array of parameters without help parameter" do
      it "print the error" do
        expect { 
          arguments = ["--default", "-f", File.join(__dir__,"../files/Ber_24.d01.TS")]
          WrfForecast.initialize(arguments)
          WrfForecast.print_help
        }.to output("Error: Module not initialized. Run WrfForecast.new(ARGV)".red + "\n" + \
                    "For help type: ruby <script> --help".green + "\n").to_stdout
      end
    end
  end

  describe "#print_version" do
    context "given the module" do
      it "print the version text" do
        expect {
          arguments = ["--version"]
          WrfForecast.initialize(arguments)
          WrfForecast.print_version
        }.to output("wrf_forecast version 0.2.0".yellow + "\n" + \
                    "Created by Benjamin Held (March 2019)".yellow + "\n").to_stdout
      end
    end
  end

  describe "#print_error" do
    context "given an error message text" do
      it "print the error message text" do
        expect {
          WrfForecast.print_error("error message")
        }.to output("error message".red + "\n" + \
                    "For help type: ruby <script> --help".green + "\n").to_stdout
      end
    end
  end

end
