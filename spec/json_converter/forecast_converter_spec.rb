require "spec_helper"
require "time"
require "wrf_forecast/json_converter"
require "fileutils"

describe WrfForecast::JsonConverter::ForecastJsonConverter do

  describe ".convert" do
    context "given a meteogram output file" do
      it "read it and create the correct json output" do
        wrf_handler = WrfLibrary::Wrf::Handler.new(File.join(__dir__,"../files/Ber_24.d01.TS"), Time.parse("2020-06-29 00:00:00 +0200"))
        forecast_handler = WrfForecast::ForecastHandler.new(wrf_handler)
        converter = WrfForecast::JsonConverter::ForecastJsonConverter.
                    new(wrf_handler.data_repository, forecast_handler.repository, forecast_handler.threshold_handler.warnings)
        converter.convert(__dir__)
        expect(FileUtils.compare_file(File.join(__dir__,"output.json"), File.join(__dir__,"../files/expected_output.json"))).to be_truthy

        # clean up data from the test and catch errors since they should not let the test fail
        File.delete(File.join(__dir__,"output.json"))
      end
    end
  end

end
