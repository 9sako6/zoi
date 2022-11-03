# frozen_string_literal: true

require_relative "lib/zoi/version"

Gem::Specification.new do |spec|
  spec.name = "zoi"
  spec.version = Zoi::VERSION
  spec.authors = ["9sako6"]
  spec.email = ["31821663+9sako6@users.noreply.github.com"]

  spec.summary = "management snippets"
  spec.description = "management snippets"
  spec.homepage = "https://github.com/9sako6/zoi"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/9sako6/zoi"
  spec.metadata["changelog_uri"] = "https://github.com/9sako6/zoi"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    %x(git ls-files -z).split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'thor'
end
