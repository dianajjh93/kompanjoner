require "rubygems"
require "metaid"
require "need"

class Object
  
  ##
  # Sets the params to their values.
  #  c.with :params => params {...}
  # does: c.params = params; blk.call; c.send :undef_meth, :params
  # 
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
  
  ##
  # Supplies the receiver to the passed block, if any.
  # 
  def tap
    yield self if block_given?
    self
  end
end

module Kompanjoner

  VERSION = '0.1'

  ##
  # Returns the version string for the library.
  #
  def self.version
    VERSION
  end

  module Helpers
  end

end

# show mercy on the poor coders
K = Kompanjoner

need{ 'kompanjoner/irc/main'     }
need{ 'kompanjoner/console/main' }
need{ 'kompanjoner/sinatra'      }
