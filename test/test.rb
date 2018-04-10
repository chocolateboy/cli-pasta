# frozen_string_literal: true

require 'komenda'
require 'minitest/autorun'
require 'minitest-power_assert'
require 'tty-which'

RUBY = 'ruby -r bundler/setup' # ensure this gem is visible in nested ruby calls
NO_TIMEOUT = 'timeout(1) is not available'
TIMEOUT = TTY::Which.which('timeout') || TTY::Which.which('gtimeout')

# XXX can't use `run` as that's a minitest builtin
def sh(command)
  Komenda.run command
end

describe 'cli-pasta' do
  it 'handles SIGINT' do
    skip NO_TIMEOUT unless TIMEOUT
    result = sh %[#{TIMEOUT} --signal INT 1 #{RUBY} -e sleep]
    assert { result.stderr =~ /Interrupt/ }
    result = sh %[#{TIMEOUT} --signal INT 1 #{RUBY} -r cli-pasta -e sleep]
    assert { result.stderr !~ /Interrupt/ }
  end

  it 'handles SIGPIPE' do
    result = sh %[#{RUBY} -e 'loop { puts "." }' | head -n0]
    assert { result.stderr =~ /EPIPE/ }
    result = sh %[#{RUBY} -r cli-pasta -e 'loop { puts "." }' | head -n0]
    assert { result.stderr !~ /EPIPE/ }
  end

  it 'handles just SIGINT' do
    result = sh %[#{RUBY} -r cli-pasta/sigint -e 'loop { puts "." }' | head -n0]
    assert { result.stderr =~ /EPIPE/ }
    skip NO_TIMEOUT unless TIMEOUT
    result = sh %[#{TIMEOUT} --signal INT 1 #{RUBY} -r cli-pasta/sigint -e sleep]
    assert { result.stderr !~ /Interrupt/ }
  end

  it 'handles just SIGPIPE' do
    result = sh %[#{RUBY} -r cli-pasta/sigpipe -e 'loop { puts "." }' | head -n0]
    assert { result.stderr !~ /EPIPE/ }
    skip NO_TIMEOUT unless TIMEOUT
    result = sh %[#{TIMEOUT} --signal INT 1 #{RUBY} -r cli-pasta/sigpipe -e sleep]
    assert { result.stderr =~ /Interrupt/ }
  end
end
