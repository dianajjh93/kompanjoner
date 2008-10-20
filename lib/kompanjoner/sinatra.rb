#  Created by ari on 2008-10-12.
#  Copyleft (c) 2008. All pwnage reserved.
require "rubygems"
require "need"
require "sinatra"

need{ '../kompanjoner' }

# Sinatra.application.lookup(faked_request)
# requests are easy to fake
# once you have the goods, just do @result.map `{|r| r.block.call }`

# params in the env hash
# @env["rack.input"]
# @env["rack.url_scheme"]
# @env["SCRIPT_NAME"]
# @env["PATH_INFO"]
# @env["SERVER_PORT"]
# @env["REQUEST_METHOD"]
# @env["QUERY_STRING"]
# @env['CONTENT_LENGTH']
# @env['CONTENT_TYPE']
# @env["HTTP_HOST"]
# @env["SERVER_NAME"]
# @env["SCRIPT_NAME"]
# @env["PATH_INFO"]
# @env["rack.request.query_string"]
# @env["rack.request.query_hash"]
# @env["rack.request.query_string"]
# @env["rack.request.query_hash"]
# @env["rack.request.form_input"]
# @env["rack.request.form_hash"]
# @env["rack.request.form_vars"]
# @env['HTTP_REFERER']
# @env["rack.request.cookie_hash"]
# @env["rack.request.cookie_string"]
# @env["HTTP_COOKIE"]
# @env["HTTP_X_REQUESTED_WITH"]
# @env["HTTP_ACCEPT_ENCODING"]

Kompanjoner::Sinatra = Module.new

##
# Fake Rack::Request class. The only difference is that
# it includes two methods that were Sinatra's additions.
# Pass this to Sinatra::application#lookup
# 
# @example Kompanjoner::Request.new 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/'
class Kompanjoner::Sinatra::Request
  
  ##
  # @param hash<Hash{String => String}> a hash that
  #   contains the values to be stored, and act as
  #   the environment (that would otherwise be passed
  #   from Rack)
  def initialize(hash={})
    (@hash = hash.dup).default = ''
  end
  
  ##
  # @see Hash
  def [](key)
    @hash[key]
  end
  
  ##
  # @see Hash
  def []=(key, value)
    @hash[key] = value
  end
  
  ##
  # Returns the hash
  # @return [Hash{String => String}]
  def env
    @hash
  end
  
  ##
  # This is a shortcut for self['REQUEST_METHOD']
  # 
  # @see Rack::Request in Sinatra's code
  def request_method
    @hash['REQUEST_METHOD']
  end
  
  ##
  # This is a shortcut for self['PATH_INFO']
  # 
  # @see Rack::Request in Sinatra's code
  def path_info
    @hash['PATH_INFO']
  end
  
  # Returns the data recieved in the query string.
  def GET
    Rack::Utils.parse_query(path_info.split('?').last)
  end

  # The union of GET and POST data.
  def params
    self.GET
  end
  
end

class Kompanjoner::EventContext

  attr_accessor :request, :response

  attr_accessor :route_params

  def initialize(request, response, route_params)
    @params = nil
    @data = nil
    @request = request
    @response = response
    @route_params = route_params
    @response.body = nil
  end

  def status(value=nil)
    response.status = value if value
    response.status
  end

  def body(value=nil)
    response.body = value if value
    response.body
  end

  def params
    @params ||=
      begin
        hash = Hash.new {|h,k| h[k.to_s] if Symbol === k}
        hash.merge! @request.params
        hash.merge! @route_params
        hash
      end
  end

  def data
    @data ||= params.keys.first
  end

  def stop(*args)
    throw :halt, args
  end

  def complete(returned)
    @response.body || returned
  end

  def session
    request.env['session'] ||= request.env['rack.session'] || {}
  end

  def reset!
    @params = nil
    @data = nil
  end

private

  def method_missing(name, *args, &b)
    if @response.respond_to?(name)
      @response.send(name, *args, &b)
    else
      super
    end
  end

end

class ::Sinatra::Application
  
  def dispatch(env)
    request = Kompanjoner::Sinatra::Request.new(env)
    context = Kompanjoner::EventContext.new(request, Rack::Response.new([], 200), {})
    begin
      returned =
        catch(:halt) do
          filters[:before].each { |f| context.instance_eval(&f) }
          result = lookup(context.request)
          context.route_params = result.params
          context.response.status = result.status
          context.reset!
          [:complete, context.instance_eval(&result.block)]
        end
      body = returned.to_result(context)
    rescue => e
      request.env['sinatra.error'] = e
      context.status(500)
      raise if options.raise_errors && e.class != NotFound
      result = (errors[e.class] || errors[Sinatra::ServerError]).invoke(request)
      returned =
        catch(:halt) do
          [:complete, context.instance_eval(&result.block)]
        end
      body = returned.to_result(context)
    end
    body = '' unless body.respond_to?(:each)
    body = '' if request.request_method.upcase == 'HEAD'
    context.body = body.kind_of?(String) ? [*body] : body
    context.finish
  end
  
end

module Kompanjoner::Sinatra
  
  ##
  # Processes the path, method, and params sent in
  # 
  # @param path<String> the path, formatted like "/foo/bar?money=5"
  # @param method<String> the request method, like "GET" or "POST" or "PUT", etc.
  # 
  # @return [String]
  def self.process(path, method)
    ::Sinatra.application.dispatch 'REQUEST_METHOD' => method, 'PATH_INFO' => path
  end
  
end
