require "spec_helper"
require "time"
require "wrf_forecast/json_converter"

describe WrfForecast::JsonConverter::ForecastStationJsonConverter do

  describe ".convert" do
    context "given a meteogram output file" do
      it "read it, create the json converter object and fail at converting to the abstract methods" do
        wrf_handler = WrfLibrary::Wrf::Handler.new(BERLIN_SMALL_DATA, Time.parse("2021-06-29 00:00:00 +0200"))
        repository = WrfForecast::ForecastRepository.new(wrf_handler)
        threshold_handler = WrfForecast::Threshold::ThresholdHandler.new(repository)
        converter = WrfForecast::JsonConverter::ForecastStationJsonConverter.
                    new(wrf_handler.data_repository, repository, threshold_handler.warnings)
        expect {
          converter.convert
        }.to raise_error(NotImplementedError)
      end
    end
  end

end
