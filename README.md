# WRF Forecast
[![Build Status](https://travis-ci.org/SettRaziel/wrf_forecast.svg?branch=development)](https://travis-ci.org/SettRaziel/wrf_forecast)
[![Maintainability](https://api.codeclimate.com/v1/badges/f8e37146f91c5b3fc933/maintainability)](https://codeclimate.com/github/SettRaziel/wrf_forecast/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/SettRaziel/wrf_forecast/badge.svg)](https://coveralls.io/github/SettRaziel/wrf_forecast)

Repository for the creation of an automated weather forecast based on station forecast data.

Current version: v0.1.6

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
 -o, --offset   argument: <offset>; specifies how many hours from the forecast should be skipped
 -p, --period   argument: <period>; specifies the forecast period
 -w, --warning  adds an additional text section containing warnings and significant weather
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
Weather forecast of Hannover for the 2020-08-01 00:00:00 +0200.

Today will be a hot day. The maximum temperature will reach up to 33 degrees celsius. The minimum temperature will be 14 degrees celsius.
The wind will be normal and will reach up to 16 km/h from southeast. The mean wind will be 9 km/h.
The forecast does predict normal rain with a maximum of 1.8 mm in 1 hour and up to 4 mm for the day. There are some dry periods during the day.
```
When using the parameter `-w` or `--warning` the forecast text will be extended by a warning section:
```
Weather forecast of Berlin-Schöneberg for the 2020-08-01 00:00:00 +0200.

Today will be a summer day. The maximum temperature will reach up to 27 degrees celsius. The minimum temperature will be 13 degrees celsius.
The wind will be normal and will reach up to 16 km/h from southeast. The mean wind will be 12 km/h.
The forecast does not predict rain.

Warnings:
summer day (temperature will exceed 25 degrees celsius) 
```

## License
see [LICENSE](https://github.com/SettRaziel/wrf_forecast/blob/development/LICENSE)

## Todos and Issues
check [issues](https://github.com/SettRaziel/wrf_forecast/issues)

created by: Benjamin Held, Feburary 2019
