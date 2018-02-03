require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => :test

task :lexer do 
  `rex lib/rm3u/lexer.rex -o lib/rm3u/lexer.rb`
end

task :parser do 
  `racc lib/rm3u/parser.racc -o lib/rm3u/parser.rb`
end

task :generate => [:lexer, :parser]
