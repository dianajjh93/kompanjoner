# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'kompanjoner'

task :default => 'spec:run'

PROJ.name = 'kompanjoner'
PROJ.authors = 'Ari Brown (seydar)'
PROJ.email = 'ari@aribrown.com'
PROJ.url = 'http://github.com/seydar/kompanjoner/'
PROJ.rubyforge.name = 'kompanjoner'
PROJ.gem.dependencies << "sinatra"
PROJ.gem.dependencies << "trollop"

PROJ.spec.opts << '--color'

# EOF
