Gem::Specification.new do |s|
  s.name          = "wrf_forecast"
  s.version       = "0.2.2"
  s.summary       = "WRF Textforecast with ruby"
  s.description   = "Scripts to generate a weather forecast based on the data of a station meteogram"
  s.authors       = ["Benjamin Held"]
  s.email         = "me@bheld.eu"
  s.homepage      = "https://github.com/settraziel/wrf_forecast"
  s.licenses      = "MIT"

  s.files         = Dir["lib/**/*.rb"] + Dir["config/locales/*.yml"] + ["README.md", "LICENSE"]
  s.require_paths = ["lib", "config"]

  s.required_ruby_version = ">= 2.4"

  s.add_development_dependency "rake", "~> 13.0", ">= 13.0.1"
  s.add_development_dependency "rspec", "~> 3.9", ">= 3.9.0"

  s.add_dependency "ruby_utils", "~> 0.2.0", "> 0.2.0"
  s.add_dependency "wrf_library", "~> 0.5.0", "> 0.5.0"
  s.add_dependency "i18n", "~> 1.8.9", ">= 1.8.9"
end
