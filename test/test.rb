# frozen_string_literal: true

require 'komenda'
require 'test/unit'
require 'tty-which'

class CLIPastaTest < Test::Unit::TestCase
  # ensure this gem is visible in nested ruby calls
  RUBY = 'ruby -r bundler/setup'

  TIMEOUT = TTY::Which.which('timeout') || TTY::Which.which('gtimeout')

  def test_epipe
    result = Komenda.run %[#{RUBY} -e 'loop { puts "." }' | head -n0]
    assert { result.stderr =~ /EPIPE/ }
    result = Komenda.run %[#{RUBY} -r cli-pasta -e 'loop { puts "." }' | head -n0]
    assert { result.stderr !~ /EPIPE/ }
  end

  def test_sigint
    if TIMEOUT
      result = Komenda.run %[#{TIMEOUT} --signal INT 1 #{RUBY} -e sleep]
      assert { result.stderr =~ /Interrupt/ }
      result = Komenda.run %[#{TIMEOUT} --signal INT 1 #{RUBY} -r cli-pasta -e sleep]
      assert { result.stderr !~ /Interrupt/ }
    end
  end

  def test_epipe_no_sigint
    result = Komenda.run %[#{RUBY} -r cli-pasta/epipe -e 'loop { puts "." }' | head -n0]
    assert { result.stderr !~ /EPIPE/ }

    if TIMEOUT
      result = Komenda.run %[#{TIMEOUT} --signal INT 1 #{RUBY} -r cli-pasta/epipe -e sleep]
      assert { result.stderr =~ /Interrupt/ }
    end
  end

  def test_sigint_no_epipe
    result = Komenda.run %[#{RUBY} -r cli-pasta/sigint -e 'loop { puts "." }' | head -n0]
    assert { result.stderr =~ /EPIPE/ }

    if TIMEOUT
      result = Komenda.run %[#{TIMEOUT} --signal INT 1 #{RUBY} -r cli-pasta/sigint -e sleep]
      assert { result.stderr !~ /Interrupt/ }
    end
  end
end
