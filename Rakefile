# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb'].exclude('test/test_helper.rb')
end

desc 'Check the codebase for style violations'
task :lint do
  sh 'rubocop', '--display-cop-names', '--config', 'resources/rubocop/rubocop.yml'
end

task :release => %i[lint test]
task :default => :test
