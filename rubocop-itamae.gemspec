
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rubocop/itamae/version"

Gem::Specification.new do |spec|
  spec.name          = "rubocop-itamae"
  spec.version       = Rubocop::Itamae::VERSION
  spec.authors       = ["sue445"]
  spec.email         = ["sue445@sue445.net"]

  spec.summary       = 'Code style checking for itamae recipes'
  spec.description   = 'Code style checking for itamae recipes'
  spec.homepage      = "https://github.com/sue445/rubocop-itamae"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rubocop"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
