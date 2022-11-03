# frozen_string_literal: true

require "minitest/autorun"
require "minitest/unit"
require "mocha/minitest"
require_relative "../lib/zoi"

class TestZoi < MiniTest::Unit::TestCase
  def test_command_exec
    assert_equal(Zoi::VERSION, `bundle exec zoi version`.chomp)
  end

  def test_command_exec_with_pipe
    assert_equal(Zoi::VERSION, `echo version | bundle exec zoi`.chomp)
  end
end
