# frozen_string_literal: true

require_relative "lib/cardano/bech32/version"

Gem::Specification.new do |spec|
  spec.name = "cardano-bech32"
  spec.version = Cardano::Bech32::VERSION
  spec.authors = ["Robin Böning"]
  spec.email = ["robin.boening@gmail.com"]

  spec.summary = "Bech32 encoding and decoding for Cardano identifiers"
  spec.description = <<~DESC
    A small, focused Ruby library for encoding and decoding Cardano Bech32 identifiers.
    The gem intentionally limits its scope to specification-compliant Bech32
    handling and avoids higher-level ledger or transaction concerns.
  DESC

  spec.homepage = "https://github.com/lacepool/cardano-bech32"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => "https://github.com/lacepool/cardano-bech32",
    "changelog_uri" => "https://github.com/lacepool/cardano-bech32/blob/main/CHANGELOG.md",
    "rubygems_mfa_required" => "true"
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .rubocop.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "bech32", "~> 1.5.0"

  spec.add_development_dependency "rspec", "~> 3.13"
end
