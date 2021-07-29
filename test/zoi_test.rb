# frozen_string_literal: true

require 'fileutils'
require 'pathname'
require 'minitest/autorun'
require 'minitest/unit'
require 'mocha/minitest'
require_relative '../lib/zoi'

class TestZoi < MiniTest::Unit::TestCase
  def setup
    @tmp_path = Pathname('./tmp')

    FileUtils.mkdir_p(@tmp_path)

    Zoi::CLI.any_instance.stubs(:root_path).returns(Pathname(Dir.pwd).join(@tmp_path).join(Zoi::ROOT_DIR_NAME).to_s)

    $stdout = File.open('/dev/null', 'w')
  end

  def teardown
    $stdout.flush
    $stdout = STDOUT
    @tmp_path.rmtree if Dir.exist?(@tmp_path)
  end

  def test_version
    assert_equal false, Zoi::VERSION.nil?
  end

  def test_create
    Zoi::CLI.start(['create', 'ruby/foo.rb'])

    assert_equal true, File.exist?('./tmp/zoi/ruby/foo.rb')
  end

  def test_list
    file_paths = %w[ruby/foo.rb python/bar.py memo.adoc]

    file_paths.each do |file_path|
      Zoi::CLI.start(['create', file_path])
    end

    output_path = @tmp_path.join('output.txt')
    $stdout = File.open(output_path, 'w')

    Zoi::CLI.start(['list'])

    $stdout.flush
    $stdout = STDOUT

    files_list = File.open(output_path, 'r', &:read).split("\n")

    assert_equal file_paths.map { |file_path| "#{Zoi::CLI.new.root_path}/#{file_path}" }.sort, files_list.sort
  end
end