require "rubygems"
require "metaid"
require "need"

module Kompanjoner

  VERSION = '0.1'

  ##
  # Returns the version string for the library.
  #
  def self.version
    VERSION
  end
  
  module Helpers
    
    ##
    # sets the params to their values
    # setting c, :params => [params, []] {...}
    # does: c.params = params; blk.call; c.params = []
    def with(hash)
      hash.each do |key, value|
        meta_def(key) { hash[key] }
        meta_def("#{key}=") { |v| hash[key] = v }
      end

      return unless block_given?

      result = yield

      hash.each do |key, value|
        meta_eval { remove_method(key) }
        meta_eval { remove_method("#{key}=") }
      end

      result
    end
    
  end

end

need{ 'kompanjoner/irc/main'     }
need{ 'kompanjoner/console/main' }
need{ 'kompanjoner/sinatra'      }
