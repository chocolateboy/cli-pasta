# frozen_string_literal: true

require 'komenda'
require 'test/unit'
require 'tty-which'

# a wrapper for `Komenda.run` which ensures the bundler environment is propagated to
# nested ruby calls.
def run_command(command) # XXX run is already taken by Test::Unit::TestCase
  Komenda.run(command, use_bundler_env: true)
end

class CLIPastaTest < Test::Unit::TestCase
  TIMEOUT = TTY::Which.which('timeout') || TTY::Which.which('gtimeout')

  def test_epipe
    result = run_command %q[ruby -e 'loop { puts "." }' | head -n0]
    assert { result.stderr =~ /EPIPE/ }
    result = run_command %q[ruby -r clipasta -e 'loop { puts "." }' | head -n0]
    assert { result.stderr !~ /EPIPE/ }
  end

  def test_sigint
    if TIMEOUT
      result = run_command %[#{TIMEOUT} --signal INT 1 ruby -e sleep]
      assert { result.stderr =~ /Interrupt/ }
      result = run_command %[#{TIMEOUT} --signal INT 1 ruby -r clipasta -e sleep]
      assert { result.stderr !~ /Interrupt/ }
    end
  end

  def test_epipe_no_sigint
    result = run_command %q[ruby -r clipasta/epipe -e 'loop { puts "." }' | head -n0]
    assert { result.stderr !~ /EPIPE/ }

    if TIMEOUT
      result = run_command %[#{TIMEOUT} --signal INT 1 ruby -r clipasta/epipe -e sleep]
      assert { result.stderr =~ /Interrupt/ }
    end
  end

  def test_sigint_no_epipe
    result = run_command %q[ruby -r clipasta/sigint -e 'loop { puts "." }' | head -n0]
    assert { result.stderr =~ /EPIPE/ }

    if TIMEOUT
      result = run_command %[#{TIMEOUT} --signal INT 1 ruby -r clipasta/sigint -e sleep]
      assert { result.stderr !~ /Interrupt/ }
    end
  end
end
