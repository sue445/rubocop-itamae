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
  spec.metadata['default_lint_roller_plugin'] = 'RuboCop::Itamae::Plugin'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'lint_roller'
  spec.add_dependency 'rubocop', '>= 1.72.0'

  spec.add_development_dependency 'bundler', '>= 1.16'
  spec.add_development_dependency 'coveralls_reborn'
  spec.add_development_dependency 'rake', '>= 11.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop_auto_corrector'
  spec.add_development_dependency 'simplecov', '< 0.18.0'
  spec.add_development_dependency 'term-ansicolor', '!= 1.11.1' # ref. https://github.com/flori/term-ansicolor/issues/41
  spec.add_development_dependency 'yard'
end
