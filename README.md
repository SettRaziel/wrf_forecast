# WRF Forecast
[![Build Status](https://travis-ci.org/SettRaziel/wrf_forecast.svg?branch=development)](https://travis-ci.org/SettRaziel/wrf_forecast)
[![Maintainability](https://api.codeclimate.com/v1/badges/f8e37146f91c5b3fc933/maintainability)](https://codeclimate.com/github/SettRaziel/wrf_forecast/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/SettRaziel/wrf_forecast/badge.svg)](https://coveralls.io/github/SettRaziel/wrf_forecast)

Repository for the creation of an automated weather forecast based on station forecast data.

Current version: v0.1.7

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
 -j, --json     returns the forecast values not as a text but a json object     
 -o, --offset   argument: <offset>; specifies how many hours from the forecast should be skipped
 -p, --period   argument: <period>; specifies the forecast period
 -s, --save     argument: <target>; specifies the output file where the results are saved
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
Weather forecast of Berlin-Schöneberg for the 2020-08-19 00:00:00 +0200

Today will be a summer day. The maximum temperature will reach up to 27 degrees celsius. The minimum temperature will be 15 degrees celsius.
The wind will be normal and will reach up to 11 km/h from west. The mean wind will be 7 km/h.
The forecast does not predict rain.

Warnings:
summer day (temperature will exceed 25 degrees celsius)
```
or with no warnings present:
```
Weather forecast of Husum for the 2020-08-19 00:00:00 +0200

Today will be a normal day. The maximum temperature will reach up to 25 degrees celsius. The minimum temperature will be 14 degrees celsius.
The wind will be normal and will reach up to 19 km/h from southwest. The mean wind will be 11 km/h.
The forecast does not predict rain.

Warnings: - 
```
With the new parameter `-j` or `--json` the output will be converted to a json object:
```
{
  "meta_data": {
    "station": {
      "name": "Berlin-Schöneberg",
      "descriptor": "Ber",
      "elevation": 44.2,
      "coordinate": {
        "x": 13.36,
        "y": 52.49
      }
    },
    "start_date": "2020-08-19 00:00:00 +0200"
  },
  "weather_data": {
    "temperature": {
      "minimum": 288.491,
      "maximum": 298.396
    },
    "wind_speed": {
      "minimum": 0.401,
      "maximum": 3.691,
      "prevalent_direction": "northwest"
    },
    "rain": {
      "minimum": 0.0,
      "maximum": 0.027,
      "sum": 0.056
    },
    "warnings": [
      "summer day (temperature will exceed 25 degrees celsius)"
    ]
  }
}
```

## License
see [LICENSE](https://github.com/SettRaziel/wrf_forecast/blob/development/LICENSE)

## Contributing
* Fork it
* Create your feature branch (git checkout -b my-new-feature)
* Commit your changes (git commit -am 'add some feature')
* Push to the branch (git push origin my-new-feature)
* Create an issue describing your work
* Create a new pull request

## Todos and Issues
check [issues](https://github.com/SettRaziel/wrf_forecast/issues)

created by: Benjamin Held, Feburary 2019
