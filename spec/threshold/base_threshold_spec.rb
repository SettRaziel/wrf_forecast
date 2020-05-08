#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-05-08 16:53:00
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-05-08 16:57:38

require 'spec_helper'
require 'wrf_forecast/threshold'

describe WrfForecast::Threshold::BaseThreshold do

  describe ".new" do
    context "given an array of temperature data for an ice day" do
      it "generate and check temperature indicators" do
        expect { 
          data_values = [ 268, 268, 268, 268, 267, 267, 267, 267, 266, 266, 
                          266, 266, 265, 265, 265, 265, 266, 266, 266, 266,
                          267, 267, 268, 268, 269, 269, 270, 270, 271, 271, 
                          271, 271, 272, 272, 271, 271, 271, 270, 270, 270,
                          269, 269, 269, 269, 268, 268, 268, 268, 268, 267
                        ]
          WrfForecast::Threshold::BaseThreshold.new(data_values)        
        }.to raise_error(NotImplementedError)
      end
    end
  end

end
