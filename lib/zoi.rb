require 'date'
require 'fileutils'
require_relative 'zoi/version'

module Zoi
  class Error < StandardError; end

  class << self
    def create
      FileUtils.mkdir_p(root_path)

      return if File.exist?(today_file)

      File.open(today_file, 'w') do |f|
        f.puts "# #{today}"
      end

      today_file
    end

    def list
      Dir.glob("#{root_path}/*")
    end

    def today_file
      File.join(root_path, file_name)
    end

    private

    def file_name
      "#{today}.md"
    end

    def today
      Date.today.strftime('%Y%m%d')
    end

    def root_path
      File.join(Dir.home, name.downcase)
    end
  end
end
