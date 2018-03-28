# frozen_string_literal: true

require 'komenda'
require 'test/unit'
require 'tty-which'

# XXX `ruby -Ilib` is needed for the tests to work work on Travis.
# otherwise, attempts to load clipasta/epipe and clipasta/sigint from nested ruby
# calls die with a LoadError.

class CLIPastaTest < Test::Unit::TestCase
  TIMEOUT = TTY::Which.which('timeout') || TTY::Which.which('gtimeout')

  def test_epipe
    result = Komenda.run %q[ruby -e 'loop { puts "." }' | head -n0]
    assert { result.stderr =~ /EPIPE/ }
    result = Komenda.run %q[ruby -Ilib -r clipasta -e 'loop { puts "." }' | head -n0]
    assert { result.stderr !~ /EPIPE/ }
  end

  def test_sigint
    if TIMEOUT
      result = Komenda.run %[#{TIMEOUT} --signal INT 1 ruby -e sleep]
      assert { result.stderr =~ /Interrupt/ }
      result = Komenda.run %[#{TIMEOUT} --signal INT 1 ruby -Ilib -r clipasta -e sleep]
      assert { result.stderr !~ /Interrupt/ }
    end
  end

  def test_epipe_no_sigint
    result = Komenda.run %q[ruby -Ilib -r clipasta/epipe -e 'loop { puts "." }' | head -n0]
    assert { result.stderr !~ /EPIPE/ }

    if TIMEOUT
      result = Komenda.run %[#{TIMEOUT} --signal INT 1 ruby -Ilib -r clipasta/epipe -e sleep]
      assert { result.stderr =~ /Interrupt/ }
    end
  end

  def test_sigint_no_epipe
    result = Komenda.run %q[ruby -Ilib -r clipasta/sigint -e 'loop { puts "." }' | head -n0]
    assert { result.stderr =~ /EPIPE/ }

    if TIMEOUT
      result = Komenda.run %[#{TIMEOUT} --signal INT 1 ruby -Ilib -r clipasta/sigint -e sleep]
      assert { result.stderr !~ /Interrupt/ }
    end
  end
end
