# frozen_string_literal: true

require "date"
require "fileutils"
require "find"
require "open3"
require "pathname"
require "thor"

module Zoi
  ROOT_DIR_NAME = "zoi"

  class CLI < Thor
    desc "create <filepath>", "Create a new file under zoi root directory."
    def create(file_path)
      return if file_path.nil?

      puts create_file(file_path)
    end

    desc "open <filepath>", <<~DESCRIPTION
      Execute `create` command and open the file with the editor specified by $EDITOR.
      For example: `EDITOR=code zoi open foobar.rb`
    DESCRIPTION
    def open(file_path)
      return if editor.nil? || file_path.nil?

      created_file_path = create_file(file_path)

      puts created_file_path

      open_file(created_file_path)
    end

    desc "list [-d]", "List all files under zoi root directory."
    option "d", type: :boolean
    def list
      only_directory = options["d"]

      puts(Find.find(root_path).select { |path| only_directory ? File.directory?(path) : File.file?(path) })
    end

    desc "memo", "Create today's memo file and open the file with the editor specified by `$EDITOR`."
    def memo
      return if editor.nil?

      created_file_path = create_file("#{Date.today}.md")

      puts created_file_path

      open_file(created_file_path)
    end

    desc "root", "Print zoi root directory."
    def root_command
      puts root_path
    end

    # NOTE: Resolve the following error.
    #       `"root" is a Thor reserved word and cannot be defined as command`
    map "root" => "root_command"

    no_tasks do
      def editor
        ENV["EDITOR"]
      end

      def create_file(file_path)
        file_full_path = File.join(root_path, file_path)

        return file_full_path if File.exist?(file_full_path)

        dir_path = File.join(root_path, File.dirname(file_path))

        FileUtils.mkdir_p(dir_path)
        FileUtils.touch(file_full_path)
        file_full_path
      end

      def open_file(file_path)
        system(editor, file_path)
      end

      def root_path
        @root_path ||= Pathname(Dir.home).join(ROOT_DIR_NAME).to_s
      end
    end
  end
end
