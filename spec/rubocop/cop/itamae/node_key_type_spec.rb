# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Itamae::NodeKeyType do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new('Itamae/NodeKeyType' => cop_config) }
  let(:cop_config) { { 'EnforcedStyle' => enforced_stype } }

  context 'EnforcedStyle: symbol' do
    let(:enforced_stype) { 'symbol' }

    context 'with symbol key' do
      it 'registers no offense' do
        expect_no_offenses(<<-RUBY.strip_indent)
          node[:ruby][:version]
        RUBY
      end
    end

    context 'with symbol key (including hyphen)' do
      it 'registers no offense' do
        expect_no_offenses(<<-RUBY.strip_indent)
          node['td-agent'][:version]
        RUBY
      end
    end

    context 'with string key (1st element)' do
      it 'registers an offense' do
        expect_offense(<<-RUBY.strip_indent)
          node['ruby'][:version]
               ^^^^^^ Use symbol key
        RUBY
      end

      include_examples 'autocorrect' do
        let(:original) do
          <<-RUBY.strip_indent
            node['ruby'][:version]
          RUBY
        end

        let(:corrected) do
          <<-RUBY.strip_indent
            node[:ruby][:version]
          RUBY
        end
      end
    end

    context 'with string key (2nd element)' do
      it 'registers an offense' do
        expect_offense(<<-RUBY.strip_indent)
          node[:ruby]['version']
                      ^^^^^^^^^ Use symbol key
        RUBY
      end

      include_examples 'autocorrect' do
        let(:original) do
          <<-RUBY.strip_indent
            node[:ruby]['version']
          RUBY
        end

        let(:corrected) do
          <<-RUBY.strip_indent
            node[:ruby][:version]
          RUBY
        end
      end
    end
  end

  context 'EnforcedStyle: string' do
    let(:enforced_stype) { 'string' }

    context 'with string key' do
      it 'registers no offense' do
        expect_no_offenses(<<-RUBY.strip_indent)
          node['ruby']['version']
        RUBY
      end
    end

    context 'with symbol key (1st element)' do
      it 'registers an offense' do
        expect_offense(<<-RUBY.strip_indent)
          node[:ruby]['version']
               ^^^^^ Use string key
        RUBY
      end

      include_examples 'autocorrect' do
        let(:original) do
          <<-RUBY.strip_indent
            node[:ruby]['version']
          RUBY
        end

        let(:corrected) do
          <<-RUBY.strip_indent
            node['ruby']['version']
          RUBY
        end
      end
    end

    context 'with symbol key (2nd element)' do
      it 'registers an offense' do
        expect_offense(<<-RUBY.strip_indent)
          node['ruby'][:version]
                       ^^^^^^^^ Use string key
        RUBY
      end

      include_examples 'autocorrect' do
        let(:original) do
          <<-RUBY.strip_indent
            node['ruby'][:version]
          RUBY
        end

        let(:corrected) do
          <<-RUBY.strip_indent
            node['ruby']['version']
          RUBY
        end
      end
    end
  end
end
