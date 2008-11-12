class Kompanjoner::Console
  def self.start(*args); new.start(*args); end
  
  def start(app, *args)
    require 'trollop'
    
    opts = Trollop::options do
      version "#{$0} #{Kompanjoner::version} (c) 2008 Ari Brown (seydar)"
      banner <<-EOS
#{$0} is written with #{app}, and is used via the command line (duh).
To call, for instance, '/main', you would use `#{$0} main`. To call
'/main/monkey?key=value' you would use `#{$0} main:monkey key:value`

Usage:
       #{$0} [options] <action>[:<action>...] <param_title>:<value> [more params...]
where [options] are:
EOS
      
      opt :verbose, "Print out the path and parameters", :short => '-V', :default => false
    end
    
    path = '/' + ARGV.shift.to_s # various actions
    path.gsub!(/:/, '/')
    
    params = ARGV.map do |arg|
      key, value = arg.split ':'
      {key => value}
    end
    
    params = params.inject({}) {|s, v| s.merge v }
    
    if opts[:verbose]
      puts "Path:   #{path.inspect}"
      puts "Params: #{params.inspect}"
    end
    
    puts app.process(path,  'GET', params)
  end
end
