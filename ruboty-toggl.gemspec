lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/toggl/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-toggl"
  spec.version       = Ruboty::Toggl::VERSION
  spec.authors       = ["hayato iida"]
  spec.email         = [""]
  spec.summary       = "Manage Toggl via Ruboty."
  spec.homepage      = "https://github.com/iida-hayato/ruboty-toggl"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "ruboty"
  spec.add_dependency "togglv8"
  spec.add_dependency "awesome_print"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "2.14.1"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "webmock"
end
