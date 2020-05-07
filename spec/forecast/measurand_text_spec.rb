#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-05-07 19:05:04
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-05-07 19:13:53

require 'spec_helper'
require 'ruby_utils/statistic'
require 'wrf_forecast/threshold'
require 'wrf_forecast/text'

describe WrfForecast::Text::MeasurandText do

  describe ".new" do
    context "given an array of data  and some extreme values" do
      it "tries to initialize the abstract class but fails in the abstract method" do
        extreme_values = RubyUtils::ExtremeValues.new(0, 2)
        expect { 
          WrfForecast::Text::MeasurandText.new(extreme_values, nil)
        }.to raise_error(NotImplementedError)
      end
    end
  end

end
