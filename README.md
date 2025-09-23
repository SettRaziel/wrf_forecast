# WRF Forecast
[![Ruby](https://github.com/SettRaziel/wrf_forecast/actions/workflows/ruby.yml/badge.svg?branch=development)](https://github.com/SettRaziel/wrf_forecast/actions/workflows/ruby.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/f8e37146f91c5b3fc933/maintainability)](https://codeclimate.com/github/SettRaziel/wrf_forecast/maintainability)

Repository for the creation of an automated weather forecast based on station forecast data.

Current version: v0.4.0

## Features
The scripts will create forecast information bases on the given input and the api method that is called.
Initially there will be two types of forecast available:
  * a general weather forecast for a given location for the specified day with the default information
    * minimal/maximal air temperature for the day (done)
    * wind information (done)
    * rain information (done)
    * air pressure information
    * warnings if measurand thresholds are exceeded (done)
  * the times for sunrise and sunset (done)
  * a specified bicycle suggestion, if it is feasible to drive to work by bike today
    * serveral special limitations apply like start time, end time

## Usage
```
script usage: ruby <script> [parameters] (-f | --file) <filename>
help usage :              ruby <script> (-h | --help)
help usage for parameter: ruby <script> <parameter> (-h | --help)
WRF forecast help:
 -h, --help      show help text
 -v, --version   prints the current version of the project
 -f, --file      argument: <file>; optional parameter that indicates a filepath to a readable file
 -a, --aggregate creates hourly values of the measurands in a json object
     --default   runs the script with date as today at midnight and a 24 h forecast period
 -j, --json      returns the forecast values not as a text but a json object
 -d, --date      argument: <date>; specifies the start_date of the requested forecast
 -l, --locale    argument: <locale>; specifies the locale in which the forecast should be printed
 -o, --offset    argument: <offset>; specifies how many hours from the forecast should be skipped
 -p, --period    argument: <period>; specifies the forecast period
 -s, --save      argument: <target>; specifies the output file where the results are saved
```
When using this as a gem the main entry point is passing the arguments to the main module:
```
WrfForecast.initialize(['--default', '-o', '6', "-f", "../files/Ber.d01.TS"])
```

## Examples
Reading a file with 24 h forecast data and creating a forecast with default parameters
```
ruby wrf_forecast.rb --default --file <filename>
```
will lead to a forecast text like this:
```
Weather forecast of Berlin-Schöneberg for the 2025-09-14 00:00:00 +0200.

Sunrise: 06:38, Sunset: 19:25
Today will be a cold day. The maximum temperature will reach up to 10 degrees celsius. The minimum temperature will be -4 degrees celsius.
The pressure today will be high with 1014.0 hPa in the mean value.The maximum pressure will not rise above 1021 hPa and the minimum will not be below 1009 hPa.
The wind will be normal and will reach up to 23 km/h from west. The mean wind will be 16 km/h.
The forecast does not predict rain.
This conditions will lead to a normal thermal sensation. The maximum apparent temperature will be 4 degrees celsius and the minimum apparent temperature -9 degrees celsius.

Warnings: 
frost day (temperature will fall below 0 degrees celsius)

```
or with no warnings present:
```
Weather forecast of Berlin-Schöneberg for the 2025-09-14 00:00:00 +0200.

Sunrise: 06:38, Sunset: 19:25
Today will be a normal day. The maximum temperature will reach up to 10 degrees celsius. The minimum temperature will be 1 degrees celsius.
The pressure today will be high with 1020.6 hPa in the mean value.The maximum pressure will not rise above 1023 hPa and the minimum will not be below 1019 hPa.
The wind will be normal and will reach up to 17 km/h from northeast. The mean wind will be 11 km/h.
The forecast does predict normal rain with a maximum of 0.3 mm in 1 hour and up to 1 mm for the day. There are some dry periods during the day.
This conditions will lead to a normal thermal sensation. The maximum apparent temperature will be 6 degrees celsius and the minimum apparent temperature -4 degrees celsius.

Warnings: -
```
The same forecast can be achieved by setting the required parameters manually:
```
ruby wrf_forecast.rb --date "2020-08-19 00:00" --period 24 --file <filename>
```
With the parameter `-j` or `--json` the output will be converted to a json object:
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
    "start_date": "2025-09-20 00:00:00 +0200",
    "suntime": {
      "sunrise": "2025-09-20 06:49:00 +0200",
      "sunset": "2025-09-20 19:11:00 +0200"
    }
  },
  "weather_data": {
    "air_temperature": {
      "minimum": 269.893,
      "maximum": 282.696
    },
    "apparent_temperature": {
      "minimum": -8.099,
      "maximum": 3.531
    },
    "pressure": {
      "minimum": 100970.313,
      "maximum": 102055.805
    },
    "rain": {
      "minimum": 0.0,
      "maximum": 0.001,
      "sum": 0.001
    },
    "wind_speed": {
      "minimum": 2.568,
      "maximum": 6.22
    },
    "wind_direction": {
      "prevalent_direction": "west"
    },
    "warnings": [
      "frost day (temperature will fall below 0 degrees celsius)"
    ]
  }
}
```
or with parameter `-a` or `--aggregate` the hourly values of the forecast day will be generated:
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
    "start_date": "2025-09-20 00:00:00 +0200",
    "suntime": {
      "sunrise": "2025-09-20 06:49:00 +0200",
      "sunset": "2025-09-20 19:11:00 +0200"
    }
  },
  "weather_data": {
    "air_temperature": [
      272.893,
      ...
      275.98
    ],
    "apparent_temperature": [
      -5.104,
      ...
      -1.253
    ],
    "pressure": [
      102024.258,
      ...
      100989.031
    ],
    "rain": [
      0.0,
      ...
      0.0
    ],
    "wind_speed": [
      2.855,
      ...
      2.94
    ],
    "wind_direction": [
      "SW",
      ...
      "W"
    ],
    "warnings": [
      "frost day (temperature will fall below 0 degrees celsius)"
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
