require 'rake/testtask'

Rake::TestTask.new(test: 'db:test:prepare')