# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name     = 'clipasta'
  spec.version  = '0.0.1'
  spec.authors  = %w[chocolateboy]
  spec.email    = %w[chocolate@cpan.org]
  spec.summary  = 'Handle Ctrl-C and broken-pipe errors gracefully in command-line tools'
  spec.homepage = 'https://github.com/chocolateboy/clipasta'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://rubygems.org'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = %w[lib]

  # spec.required_ruby_version = '>= 2.3.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'komenda', '~> 0.1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.54.0'
  spec.add_development_dependency 'test-unit', '~> 3.2'
  spec.add_development_dependency 'tty-which', '~> 0.3.0'
end
