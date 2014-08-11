# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'loggem/version'

Gem::Specification.new do |spec|
  spec.name          = "loggem"
  spec.version       = Loggem::VERSION
  spec.authors       = ["Istvan Demeter"]
  spec.email         = ["istvan.demeter@emarsys.com"]
  spec.summary       = %q{Simple log wrapper with different formatters. Rails/ActiveRecord/Sequel support, so far}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/emartech/loggem"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
