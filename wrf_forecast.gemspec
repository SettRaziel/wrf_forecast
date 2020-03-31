Gem::Specification.new do |s|
  s.name          = "wrf_forecast"
  s.version       = "0.0.1"
  s.summary       = "WRF Testforecast with ruby"
  s.description   = "Scripts to generate a weather forecast based on the data of a station meteogram"
  s.authors       = ["Benjamin Held"]
  s.email         = "me@bheld.eu"
  s.homepage      = "https://github.com/settraziel/wrf_forecast"
  s.licenses      = "MIT"

  s.files         = Dir["lib/**/*.rb"] + ["README.md", "LICENSE"]
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 2.4"

  s.add_development_dependency "rake",      '~> 13.0', '>= 13.0.1'
  s.add_development_dependency "rspec", '~> 3.9', '>= 3.9.0'
  s.add_dependency "wrf_library", '~> 0.0.1'
end
