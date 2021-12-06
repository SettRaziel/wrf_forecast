require "spec_helper"
require "time"
require "wrf_forecast/json_converter"
require "fileutils"

describe WrfForecast::JsonConverter::HourlyForecastJsonConverter do

  describe ".convert" do
    context "given a meteogram output file" do
      it "read it and create the correct json output" do
        wrf_handler = WrfLibrary::Wrf::Handler.new(BERLIN_SMALL_DATA, Time.parse("2021-06-29 00:00:00 +0200"))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        converter = WrfForecast::JsonConverter::HourlyForecastJsonConverter.new(wrf_handler, repository, threshold_handler.warnings)
        converter.convert(__dir__)
        expect(FileUtils.compare_file(File.join(__dir__,"output.json"), File.join(__dir__,"../files/expected_hourly_output.json"))).to be_truthy
        
        # clean up data from the test and catch errors since they should not let the test fail
        File.delete(File.join(__dir__,"output.json"))
      end
    end
  end

end
