require "/Volumes/music/src/kompanjoner.code/lib/kompanjoner.rb"
require "/Volumes/music/src/kompanjoner.code/lib/kompanjoner/sinatra.rb"

get '/hello' do
  "hello, world!"
end

K::Console.start K::Sinatra
