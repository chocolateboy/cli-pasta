# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb'].exclude('test/test_helper.rb')
end

desc 'Check the codebase for style violations'
task :rubocop do
  sh 'rubocop', '--display-cop-names', '--config', 'resources/rubocop/rubocop.yml'
end

# no need for bin/console
# http://erniemiller.org/2014/02/05/7-lines-every-gems-rakefile-should-have/
desc 'launch IRB with this gem loaded'
task :console do
  require 'irb'
  require 'irb/completion'
  require 'cli-pasta'
  ARGV.clear
  IRB.start
end

task :release => %i[rubocop test]
task :default => :test
