# WRF Forecast
[![Build Status](https://travis-ci.org/SettRaziel/wrf_forecast.svg?branch=development)](https://travis-ci.org/SettRaziel/wrf_forecast)
[![Maintainability](https://api.codeclimate.com/v1/badges/f8e37146f91c5b3fc933/maintainability)](https://codeclimate.com/github/SettRaziel/wrf_forecast/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/SettRaziel/wrf_forecast/badge.svg)](https://coveralls.io/github/SettRaziel/wrf_forecast)

Repository for the creation of an automated weather forecast based on station forecast data.

Current version: v0.1.3

## Features
The scripts will create forecast information bases on the given input and the api method that is called.
Initially there will be two types of forecast available:
  * a general weather forecast for a given location for the specified day with the default information
    * minimal/maximal air temperature for the day
    * wind information
    * rain information
    * air pressure information
  * a specified bicycle suggestion, if it is feasible to drive to work by bike today
    * serveral special limitations apply like start time, end time

## Usage
```
script usage: ruby <script> [parameters] <filename>
help usage :              ruby <script> (-h | --help)
help usage for parameter: ruby <script> <parameter> (-h | --help)
WRF forecast help:
 -h, --help     show help text
 -v, --version  prints the current version of the project
 -d, --date     argument: <date>; specifies the start_date of the requested forecast
     --default  runs the script with date as today at midnight and a 24 h forecast period
 -p, --period   argument: <period>; specifies the forecast period
```
When using this as a gem the main entry point is passing the arguments to the main module:
```
WrfForecast.initialize(['--default', '-o', '6', "../files/Ber.d01.TS"])
```

## Examples
Reading a file with 24 h forecast data and creating a forecast with default parameters
```
ruby wrf_forecast.rb --default <filename>
```
will lead to a forecast text like this:
```
Weather forecast of Hannover for the 2020-03-30 00:00:00 +0200.

Today will be a cold day. The maximum temperature will reach up to 16 degrees celsius. The minimum temperature will be -1 degrees celsius.
The wind will be normal and will reach up to 24 km/h from northeast. The mean wind will be 17 km/h.
The forecast does not predict rain.
```

## License
see LICENSE

## Todo
* Basic project structure

created by: Benjamin Held, Feburary 2019
