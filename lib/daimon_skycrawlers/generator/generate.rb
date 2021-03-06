require "thor"
require "pathname"
require "daimon_skycrawlers/generator/crawler"
require "daimon_skycrawlers/generator/processor"
require "daimon_skycrawlers/generator/filter"

module DaimonSkycrawlers
  # @private
  module Generator
    # @private
    class Generate < Thor
      register(Crawler, "crawler", "crawler NAME", "Generate new crawler")
      register(Processor, "processor", "processor NAME", "Generate new processor")
      register(Filter, "filter", "filter NAME", "Generate new filter")
    end
  end
end
