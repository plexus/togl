# coding: utf-8

require File.expand_path("../lib/togl/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "togl"
  spec.version       = Togl::VERSION
  spec.authors       = ["Arne Brasseur"]
  spec.email         = ["arne@arnebrasseur.net"]
  spec.summary       = %q{Perfect Features Toggles}
  spec.description   = %q{Multi-strategy feature flags.}
  spec.homepage      = "https://github.com/plexus/togl"
  spec.license       = "MIT"

  spec.require_paths = ["lib"]
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.extra_rdoc_files = %w[README.md]

  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "attribs", "~> 1.0"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "mutant-rspec"
  spec.add_development_dependency "bogus"
end
