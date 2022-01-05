require "spec_helper"
require "wrf_forecast/transform"

describe WrfForecast::RainSnowTransformation do

  describe "#rain_to_snow" do
    context "given a rain amount and a valid temperature" do
      it "transform and return the corresponding snow amount" do
        expect(WrfForecast::RainSnowTransformation.rain_to_snow(1, 273.15 )).to eq(10)
      end
    end
  end

  describe "#rain_to_snow" do
    context "given a rain amount and a valid temperature" do
      it "transform and return the corresponding snow amount" do
        expect(WrfForecast::RainSnowTransformation.rain_to_snow(1, 265.15 )).to eq(20)
      end
    end
  end

  describe "#rain_to_snow" do
    context "given a rain amount and a valid temperature" do
      it "transform and return the corresponding snow amount" do
        expect(WrfForecast::RainSnowTransformation.rain_to_snow(1, 246.15 )).to eq(50)
      end
    end
  end

    describe "#rain_to_snow" do
    context "given a rain amount and an invalid temperature" do
      it "try transform and return nil" do
        expect(WrfForecast::RainSnowTransformation.rain_to_snow(1, 286.15 )).to eq(nil)
      end
    end
  end

  describe "#snow_to_rain" do
    context "given a snow amount and a valid temperature" do
      it "transform and return the corresponding rain amount" do
        expect(WrfForecast::RainSnowTransformation.snow_to_rain(15, 268.15 )).to eq(1)
      end
    end
  end

  describe "#snow_to_rain" do
    context "given a snow amount and a valid temperature" do
      it "transform and return the corresponding rain amount" do
        expect(WrfForecast::RainSnowTransformation.snow_to_rain(40, 257.15 )).to eq(1)
      end
    end
  end

  describe "#snow_to_rain" do
    context "given a snow amount and a valid temperature" do
      it "transform and return the corresponding rain amount" do
        expect(WrfForecast::RainSnowTransformation.snow_to_rain(100, 234.15 )).to eq(1)
      end
    end
  end

  describe "#snow_to_rain" do
    context "given a snow amount and an invalid temperature" do
      it "try transform and return nil" do
        expect(WrfForecast::RainSnowTransformation.snow_to_rain(100, 284.15 )).to eq(nil)
      end
    end
  end

end
