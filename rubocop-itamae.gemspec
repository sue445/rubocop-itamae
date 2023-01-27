# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubocop/itamae/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubocop-itamae'
  spec.version       = RuboCop::Itamae::VERSION
  spec.authors       = ['sue445']
  spec.email         = ['sue445@sue445.net']

  spec.summary       = 'Code style checking for itamae recipes'
  spec.description   = 'Code style checking for itamae recipes'
  spec.homepage      = 'https://github.com/sue445/rubocop-itamae'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/master/CHANGELOG.md"
  spec.metadata['documentation_uri'] = 'https://sue445.github.io/rubocop-itamae/'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5.0'

  spec.add_dependency 'rubocop', '>= 1.13.0'

  spec.add_development_dependency 'bundler', '>= 1.16'
end
