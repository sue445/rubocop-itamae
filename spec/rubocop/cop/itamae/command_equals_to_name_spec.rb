# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Itamae::CommandEqualsToName, :config do
  subject(:cop) { described_class.new }

  context 'with block' do
    context 'command equals to name' do
      it 'registers an offense' do
        expect_offense(<<-RUBY)
          execute 'rm -rf /tmp/*' do
            command 'rm -rf /tmp/*'
            ^^^^^^^^^^^^^^^^^^^^^^^ Itamae/CommandEqualsToName: Prefer to omit `command` if `command` equals to name of `execute`
          end
        RUBY
      end

      context 'includes only command' do
        include_examples 'autocorrect' do
          let(:original) do
            <<-RUBY
              execute 'rm -rf /tmp/*' do
                command 'rm -rf /tmp/*'
              end
            RUBY
          end

          let(:corrected) do
            <<-RUBY
              execute 'rm -rf /tmp/*' do
              end
            RUBY
          end
        end
      end

      context 'includes other params' do
        include_examples 'autocorrect' do
          let(:original) do
            <<-RUBY
              execute 'rm -rf /tmp/*' do
                command 'rm -rf /tmp/*'
                cwd '/tmp'
              end
            RUBY
          end

          let(:corrected) do
            <<-RUBY
              execute 'rm -rf /tmp/*' do
                cwd '/tmp'
              end
            RUBY
          end
        end
      end
    end

    context 'command does not equals to name' do
      it 'registers no offense' do
        expect_no_offenses(<<-RUBY)
          execute 'Remove temporary files' do
            command 'rm -rf /tmp/*'
          end
        RUBY
      end
    end

    context 'without command' do
      it 'registers no offense' do
        expect_no_offenses(<<-RUBY)
          execute 'rm -rf /tmp/*' do
          end
        RUBY
      end
    end
  end

  context 'without block' do
    it 'registers no offense' do
      expect_no_offenses(<<-RUBY)
        execute 'rm -rf /tmp/*'
      RUBY
    end
  end
end
