# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "microform/version"

Gem::Specification.new do |spec|
  spec.name          = "microform"
  spec.version       = Microform::VERSION
  spec.authors       = ["Standard Library"]
  spec.email         = ["office@standard-library.com"]

  spec.summary       = %q{The smallest possible form object pattern for Rails.}
  spec.description   = %q{The smallest possible form object pattern for Rails.}
  spec.homepage      = "https://github.com/standard-library/microform"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["lib/**/*"]
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 5.0"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
