require "spec_helper"
require "wrf_forecast/data/directions"

describe WrfForecast::Directions do
  
  describe ".get_direction_string" do
    context "given an object of the class" do
      it "should return the correct direction strings for the given symbol" do
        directions = WrfForecast::Directions.new()

        expect(directions.get_direction_string(:N)).to eq("north")
        expect(directions.get_direction_string(:S)).to eq("south")
        expect(directions.get_direction_string(:W)).to eq("west")
        expect(directions.get_direction_string(:E)).to eq("east")
        expect(directions.get_direction_string(:NW)).to eq("northwest")
        expect(directions.get_direction_string(:NE)).to eq("northeast")
        expect(directions.get_direction_string(:SW)).to eq("southwest")
        expect(directions.get_direction_string(:SE)).to eq("southeast")
      end
    end
  end

  describe ".get_direction_string" do
    context "given an object of the class" do
      before (:all) do
        WrfForecast::LocaleConfiguration.change_locale(:de)
      end
      it "should return the correct direction strings for the given symbol" do

        directions = WrfForecast::Directions.new()

        expect(directions.get_direction_string(:N)).to eq("Nord")
        expect(directions.get_direction_string(:S)).to eq("Süd")
        expect(directions.get_direction_string(:W)).to eq("West")
        expect(directions.get_direction_string(:E)).to eq("Ost")
        expect(directions.get_direction_string(:NW)).to eq("Nordwest")
        expect(directions.get_direction_string(:NE)).to eq("Nordost")
        expect(directions.get_direction_string(:SW)).to eq("Südwest")
        expect(directions.get_direction_string(:SE)).to eq("Südost")

      end
      after (:all) do
        WrfForecast::LocaleConfiguration.change_locale(:en)
      end
    end
  end

end
