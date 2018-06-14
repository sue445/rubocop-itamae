# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

Dir['tasks/**/*.rake'].each { |t| load t }

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
