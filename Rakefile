# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "rubocop/rake_task"

task default: [:"rubocop:auto_correct", :test]

Rake::TestTask.new do |test|
  test.test_files = FileList["./test/*.rb"]
  # Display detail information.
  test.verbose = true
end

RuboCop::RakeTask.new
