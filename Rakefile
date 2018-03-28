# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*.rb']
  t.verbose = true
end

desc 'Check the codebase for style violations'
task :rubocop do
  sh 'rubocop', '--display-cop-names', '--config', '.rubocop/rubocop.yml'
end

task :default => :test
