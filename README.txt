kompanjoner
    by Ari Brown (seydar)
    http://github.com/seydar/kompanjoner/tree

== DESCRIPTION:

Kompanjoner is a tool to make web frameworks, like Sinatra and Merb,
pretend to be command line apps or IRC bots.

== FEATURES/PROBLEMS:

* Sinatra is fully supported, except for sessions and cookies
* No subcommands (yet!)
* Help page provided

== SYNOPSIS:

  require 'rubygems'
  require 'kompanjoner/sinatra'
    
  get 'hello' do
    "hello, world!"
  end
  
  K::Console.start K::Sinatra
  

== REQUIREMENTS:

  * sinatra [, merb]
  * trollop
  * a wish for the return of console apps

== INSTALL:

  [sudo] gem install kompanjoner

== LICENSE:

(The MIT License)

Copyright (c) 2008 FIXME (different license?)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
