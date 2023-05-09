require "spec_helper"
require "wrf_forecast/help/help_output"

describe WrfForecast::HelpOutput do

  describe "#print_help_for" do
    context "given a simple help entry" do
      it "print the help text for :default" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(:default) 
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    "     --default   ".light_blue +  \
                    "runs the script with date as today at midnight and a 24 h forecast period\n").to_stdout
      end
    end
  end

  describe "#print_help_for" do
    context "given a simple help entry" do
      it "print the help text for :warning" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(:json) 
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    " -j, --json      ".light_blue +  \
                    "returns the forecast values not as a text but a json object\n").to_stdout
      end
    end
  end

  describe "#print_help_for" do
    context "given a one element help entry" do
      it "print the help text for :period" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(:period) 
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    " -p, --period    ".light_blue + "argument:".red + " <period>".yellow  + \
                    "; specifies the forecast period, if not set a default of 24 is set\n").to_stdout
      end
    end
  end

  describe "#print_help_for" do
    context "given a one element help entry" do
      it "print the help text for :date" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(:date) 
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    " -d, --date      ".light_blue + "argument:".red + " <date>".yellow  + \
                    "; specifies the start_date of the requested forecast\n").to_stdout
      end
    end
  end

describe "#print_help_for" do
    context "given a one element help entry" do
      it "print the help text for :locale" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(:locale) 
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    " -l, --locale    ".light_blue + "argument:".red + " <locale>".yellow  + \
                    "; specifies the locale in which the forecast should be printed\n").to_stdout
      end
    end
  end

  describe "#print_help_for" do
    context "given a one element help entry" do
      it "print the help text for :offset" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(:offset) 
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    " -o, --offset    ".light_blue + "argument:".red + " <offset>".yellow  + \
                    "; specifies how many hours from the forecast should be skipped\n").to_stdout
      end
    end
  end

  describe "#print_help_for" do
    context "given a one element help entry" do
      it "print the help text for :save" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(:save) 
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    " -s, --save      ".light_blue + "argument:".red + " <target>".yellow  + \
                    "; specifies the output file where the results are saved\n").to_stdout
      end
    end
  end

    describe "#print_help_for" do
    context "given a one element help entry" do
      it "print the help text for :save" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(:aggregate) 
        }.to output("WRF forecast help:".light_yellow + "\n" + \
                    " -a, --aggregate ".light_blue + \
                    "creates hourly values of the measurands in a json object\n").to_stdout
      end
    end
  end

  describe "#print_help_for" do
    context "given a to whole help text" do
      it "print the help text for the script" do
        expect { 
          WrfForecast::HelpOutput.print_help_for(true)
        }.to output("script usage:".red + " ruby <script> [parameters] <filename>\n" + \
                    "help usage :".green + "              ruby <script> (-h | --help)\n" + \
                    "help usage for parameter:".green + " ruby <script> <parameter> (-h | --help)\n" + \
                    "WRF forecast help:".light_yellow + "\n" + \
                    " -h, --help      ".light_blue + "show help text\n" + \
                    " -v, --version   ".light_blue + "prints the current version of the project\n" + \
                    " -f, --file      ".light_blue + "argument:".red + " <file>".yellow + \
                    "; optional parameter that indicates a filepath to a readable file\n" + \
                    " -a, --aggregate ".light_blue + \
                    "creates hourly values of the measurands in a json object\n" + \
                    "     --default   ".light_blue +  \
                    "runs the script with date as today at midnight and a 24 h forecast period\n" + \
                    " -j, --json      ".light_blue +  \
                    "returns the forecast values not as a text but a json object\n" + \
                    " -d, --date      ".light_blue + "argument:".red + " <date>".yellow  + \
                    "; specifies the start_date of the requested forecast\n" + \
                    " -l, --locale    ".light_blue + "argument:".red + " <locale>".yellow  + \
                    "; specifies the locale in which the forecast should be printed\n" + \
                    " -o, --offset    ".light_blue + "argument:".red + " <offset>".yellow  + \
                    "; specifies how many hours from the forecast should be skipped\n" + \
                    " -p, --period    ".light_blue + "argument:".red + " <period>".yellow  + \
                    "; specifies the forecast period, if not set a default of 24 is set\n" + \
                    " -s, --save      ".light_blue + "argument:".red + " <target>".yellow  + \
                    "; specifies the output file where the results are saved\n").to_stdout
      end
    end
  end  

end
