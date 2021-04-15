require "spec_helper"
require "wrf_forecast/data/directions"

describe WrfForecast::Directions do
  
  describe ".get_direction_string" do
    context "given an object of the class" do
      it "should return the correct direction strings for the given symbol" do
        directions = WrfForecast::Directions.new()

        expect(directions.get_direction_string(:N)).to eq(I18n.t("direction.north"))
        expect(directions.get_direction_string(:S)).to eq(I18n.t("direction.south"))
        expect(directions.get_direction_string(:W)).to eq(I18n.t("direction.west"))
        expect(directions.get_direction_string(:E)).to eq(I18n.t("direction.east"))
        expect(directions.get_direction_string(:NW)).to eq(I18n.t("direction.northwest"))
        expect(directions.get_direction_string(:NE)).to eq(I18n.t("direction.northeast"))
        expect(directions.get_direction_string(:SW)).to eq(I18n.t("direction.southwest"))
        expect(directions.get_direction_string(:SE)).to eq(I18n.t("direction.southeast"))
      end
    end
  end

end
