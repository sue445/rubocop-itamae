# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in rubocop-itamae.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create('2.3.0')
  # byebug 11.0.0+ requires Ruby 2.3.0+
  gem 'byebug', '< 11.0.0'
end
