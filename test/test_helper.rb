# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest-power_assert'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

module Minitest
  class Result
    # unmangle the displayed test names (use the original description).
    # (see the definition of the `it` method in minitest/spec.rb)
    #
    #   - before: test_0001_foo the bar
    #   - after: foo the bar
    #
    # inspired by: https://stackoverflow.com/q/24149581

    alias old_name name

    def name
      old_name.sub(/\Atest_\d+_/, '')
    end
  end
end
