# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name     = 'cli-pasta'
  spec.version  = '2.0.0'
  spec.author   = 'chocolateboy'
  spec.email    = 'chocolate@cpan.org'
  spec.summary  = 'Handle Ctrl-C and broken-pipe errors gracefully in Ruby command-line tools'
  spec.homepage = 'https://github.com/chocolateboy/cli-pasta'
  spec.license  = 'Artistic-2.0'

  spec.files = `git ls-files -z *.md bin lib`.split("\0")

  spec.required_ruby_version = '>= 2.5.0'

  spec.metadata = {
    'allowed_push_host' => 'https://rubygems.org',
    'bug_tracker_uri'   => 'https://github.com/chocolateboy/cli-pasta/issues',
    'changelog_uri'     => 'https://github.com/chocolateboy/cli-pasta/blob/master/CHANGELOG.md',
    'source_code_uri'   => 'https://github.com/chocolateboy/cli-pasta',
  }

  spec.add_development_dependency 'bundler', '~> 2.1.4'
  spec.add_development_dependency 'komenda', '~> 0.1.8'
  spec.add_development_dependency 'minitest', '~> 5.14'
  spec.add_development_dependency 'minitest-power_assert', '~> 0.3.0'
  spec.add_development_dependency 'minitest-reporters', '~> 1.4'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 0.93'
  spec.add_development_dependency 'tty-which', '~> 0.4.2'
end
