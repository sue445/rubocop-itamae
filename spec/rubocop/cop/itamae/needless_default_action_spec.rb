# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Itamae::NeedlessDefaultAction do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  context 'with default action' do
    it 'registers an offense' do
      expect_offense(<<~RUBY)
        package 'git' do
          action :install
          ^^^^^^^^^^^^^^^ Itamae/NeedlessDefaultAction: Prefer to omit the default action.
        end
      RUBY
    end

    include_examples 'autocorrect' do
      let(:original) do
        <<~RUBY
          package 'git' do
            action :install
          end
        RUBY
      end

      let(:corrected) do
        <<~RUBY
          package 'git' do
          end
        RUBY
      end
    end
  end

  context 'with non-default action' do
    it 'registers no offense' do
      expect_no_offenses(<<-RUBY)
        package 'git' do
          action :remove
        end
      RUBY
    end
  end
end
