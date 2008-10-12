require "rubygems"
require "need"

module Kompanjoner

  VERSION = '0.1'

  ##
  # Returns the version string for the library.
  #
  def self.version
    VERSION
  end

end

need{ 'kompanjoner/irc/main'     }
need{ 'kompanjoner/console/main' }
need{ 'kompanjoner/sinatra'      }
