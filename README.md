# WRF Forecast
[![Maintainability](https://api.codeclimate.com/v1/badges/f8e37146f91c5b3fc933/maintainability)](https://codeclimate.com/github/SettRaziel/wrf_forecast/maintainability)

Repository for the creation of an automated weather forecast based on station forecast data.

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
```

## License
see LICENSE

## Todo
* Basic project structure

created by: Benjamin Held, Feburary 2019
