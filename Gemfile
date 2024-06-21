# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in rubocop-itamae.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create('2.7.0')
  # term-ansicolor 1.9.0+ doesn't work on Ruby < 2.7
  gem 'term-ansicolor', '< 1.9.0'
end
