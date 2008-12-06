require "/Volumes/music/src/kompanjoner.code/lib/kompanjoner/sinatra.rb"
require "/Volumes/music/src/kompanjoner.code/lib/kompanjoner/console/main.rb"
require "trollop"

K::options do |opt|
  opt.opt :awesome, "Be awesome!", :short => '-a', :default => false
end

get('/hello')   { "hello, world!" }
get('/goodbye') { "goodbye, world!" }
get('/awesome') { "I'M SO AWESOME!"}

get('/hello/:name')   { "hello, #{params[:name]}!" }
get('/goodbye/:name') { "goodbye, #{params[:name]}!" }

get('/testy/lesty') { "hey there, #{params['test']}" }

not_found { "Dude, --help!" }

K::Console.start K::Sinatra
