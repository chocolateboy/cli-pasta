# frozen_string_literal: true

require 'komenda'
require 'minitest/autorun'
require 'minitest-power_assert'
require 'tty-which'

# ensure this gem is visible in nested ruby calls
RUBY = 'ruby -r bundler/setup'

TIMEOUT = TTY::Which.which('timeout') || TTY::Which.which('gtimeout')

# XXX can't use `run` as that's a minitest builtin
def sh(command)
  Komenda.run command
end

describe 'cli-pasta' do
  it 'handles EPIPE errors' do
    result = sh %[#{RUBY} -e 'loop { puts "." }' | head -n0]
    assert { result.stderr =~ /EPIPE/ }
    result = sh %[#{RUBY} -r cli-pasta -e 'loop { puts "." }' | head -n0]
    assert { result.stderr !~ /EPIPE/ }
  end

  it 'handles SIGINT signals' do
    if TIMEOUT
      result = sh %[#{TIMEOUT} --signal INT 1 #{RUBY} -e sleep]
      assert { result.stderr =~ /Interrupt/ }
      result = sh %[#{TIMEOUT} --signal INT 1 #{RUBY} -r cli-pasta -e sleep]
      assert { result.stderr !~ /Interrupt/ }
    end
  end

  it 'handles just EPIPE errors' do
    result = sh %[#{RUBY} -r cli-pasta/epipe -e 'loop { puts "." }' | head -n0]
    assert { result.stderr !~ /EPIPE/ }

    if TIMEOUT
      result = sh %[#{TIMEOUT} --signal INT 1 #{RUBY} -r cli-pasta/epipe -e sleep]
      assert { result.stderr =~ /Interrupt/ }
    end
  end

  it 'handles just SIGPIPE signals' do
    result = sh %[#{RUBY} -r cli-pasta/sigint -e 'loop { puts "." }' | head -n0]
    assert { result.stderr =~ /EPIPE/ }

    if TIMEOUT
      result = sh %[#{TIMEOUT} --signal INT 1 #{RUBY} -r cli-pasta/sigint -e sleep]
      assert { result.stderr !~ /Interrupt/ }
    end
  end
end
