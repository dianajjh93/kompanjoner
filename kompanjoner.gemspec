Gem::Specification.new do |s|
  s.name     = "kompanjoner"
  s.version  = "0.1"
  s.date     = "2008-12-06"
  s.summary  = "Make Sinatra[, Merb...] play on the command line, too!"
  s.email    = "ari@aribrown.com"
  s.homepage = "http://github.com/seydar/kompanjoner"
  s.description = "Frameworks need a few buds to listen to other signals, such as IRC or the console!"
  s.authors  = ["Ari Brown"]
  s.files    = ["History.txt",
                "lib/kompanjoner/console/main.rb",
                "lib/kompanjoner/irc/main.rb",
                "lib/kompanjoner/sinatra.rb",
                "lib/kompanjoner.rb",
                "Manifest.txt",
                "Rakefile",
                "README.txt",
                "spec/kompanjoner_spec.rb",
                "spec/spec_helper.rb",
                "tasks/ann.rake",
                "tasks/bones.rake",
                "tasks/gem.rake",
                "tasks/git.rake",
                "tasks/manifest.rake",
                "tasks/notes.rake",
                "tasks/post_load.rake",
                "tasks/rdoc.rake",
                "tasks/rubyforge.rake",
                "tasks/setup.rb",
                "tasks/spec.rake",
                "tasks/svn.rake",
                "tasks/test.rake"] 
  s.test_files = ["test/test_kopmanjoner.rb"] 
  s.add_dependency("trollop")
  s.add_dependency("sinatra")
end
