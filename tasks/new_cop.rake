# frozen_string_literal: true

require 'rubocop'

desc 'Generate a new cop template'
task :new_cop, [:cop] do |_task, args|
  cop_name = args.fetch(:cop) do
    warn 'usage: bundle exec rake new_cop[Department/Name]'
    exit!
  end

  github_user = `git config github.user`.chop
  github_user = 'your_id' if github_user.empty?

  generator = RuboCop::Cop::Generator.new(cop_name, github_user)

  generator.write_source
  generator.write_spec
  generator.inject_require(root_file_path: 'lib/rubocop/cop/itamae_cops.rb')

  begin
    generator.inject_config(config_file_path: 'config/default.yml')
  rescue TypeError
    # nop
  end

  # puts generator.todo
end
