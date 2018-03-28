# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name     = 'cli-pasta'
  spec.version  = '1.0.0'
  spec.author   = 'chocolateboy'
  spec.email    = 'chocolate@cpan.org'
  spec.summary  = 'Handle Ctrl-C and broken-pipe errors gracefully in Ruby command-line tools'
  spec.homepage = 'https://github.com/chocolateboy/cli-pasta'
  spec.license  = 'Artistic-2.0'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://rubygems.org'
  end

  spec.files = `git ls-files -z *.md bin lib`.split("\0")

  spec.require_paths = %w[lib]

  # spec.required_ruby_version = '>= 2.3.0'

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/chocolateboy/cli-pasta/issues',
    'changelog_uri'   => 'https://github.com/chocolateboy/cli-pasta/blob/master/CHANGELOG.md',
    'source_code_uri' => 'https://github.com/chocolateboy/cli-pasta',
  }

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'komenda', '~> 0.1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.54.0'
  spec.add_development_dependency 'test-unit', '~> 3.2'
  spec.add_development_dependency 'tty-which', '~> 0.3.0'
end
