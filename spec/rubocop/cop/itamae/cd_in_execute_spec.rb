# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Itamae::CdInExecute, :config do
  subject(:cop) { described_class.new }

  context 'execute with cd' do
    context 'without command param' do
      context 'without other params' do
        it 'registers an offense' do
          expect_offense(<<-RUBY)
            execute 'cd /tmp && rm -rf /tmp/*'
                     ^^^^^^^^^^^ Insert `cwd '/tmp'` and remove this.
          RUBY
        end

        # include_examples 'autocorrect' do
        #   let(:original) do
        #     <<-RUBY
        #       execute 'cd /tmp && rm -rf /tmp/*'
        #     RUBY
        #   end
        #
        #   let(:corrected) do
        #     <<-RUBY
        #       execute 'rm -rf /tmp/*' do
        #         cwd '/tmp'
        #       end
        #     RUBY
        #   end
        # end
      end

      context 'with other params' do
        it 'registers an offense' do
          expect_offense(<<-RUBY)
            execute 'cd /tmp && rm -rf /tmp/*' do
                     ^^^^^^^^^^^ Insert `cwd '/tmp'` and remove this.
              only_if 'ls -l /tmp/*'
            end
          RUBY
        end

        # include_examples 'autocorrect' do
        #   let(:original) do
        #     <<-RUBY
        #       execute 'cd /tmp && rm -rf /tmp/*' do
        #         only_if 'ls -l /tmp/*'
        #       end
        #     RUBY
        #   end
        #
        #   let(:corrected) do
        #     <<-RUBY
        #       execute 'rm -rf /tmp/*' do
        #         cwd '/tmp'
        #         only_if 'ls -l /tmp/*'
        #       end
        #     RUBY
        #   end
        # end
      end
    end

    context 'with command param' do
      context 'without other params' do
        it 'registers an offense' do
          expect_offense(<<-RUBY)
            execute 'Remove temporary files' do
              command 'cd /tmp && rm -rf /tmp/*'
                       ^^^^^^^^^^^ Insert `cwd '/tmp'` and remove this.
            end
          RUBY
        end

        # include_examples 'autocorrect' do
        #   let(:original) do
        #     <<-RUBY
        #       execute 'Remove temporary files' do
        #         command 'cd /tmp && rm -rf /tmp/*'
        #       end
        #     RUBY
        #   end
        #
        #   let(:corrected) do
        #     <<-RUBY
        #       execute 'Remove temporary files' do
        #         command 'rm -rf /tmp/*'
        #         cwd '/tmp'
        #       end
        #     RUBY
        #   end
        # end
      end

      context 'with other params' do
        it 'registers an offense' do
          expect_offense(<<-RUBY)
            execute 'Remove temporary files' do
              command 'cd /tmp && rm -rf /tmp/*'
                       ^^^^^^^^^^^ Insert `cwd '/tmp'` and remove this.
              only_if 'ls -l /tmp/*'
            end
          RUBY
        end

        # include_examples 'autocorrect' do
        #   let(:original) do
        #     <<-RUBY
        #       execute 'Remove temporary files' do
        #         command 'cd /tmp && rm -rf /tmp/*'
        #         only_if 'ls -l /tmp/*'
        #       end
        #     RUBY
        #   end
        #
        #   let(:corrected) do
        #     <<-RUBY
        #       execute 'Remove temporary files' do
        #         command 'rm -rf /tmp/*'
        #         cwd '/tmp'
        #         only_if 'ls -l /tmp/*'
        #       end
        #     RUBY
        #   end
        # end
      end
    end
  end

  context 'execute without cd' do
    context 'without command param' do
      it 'registers no offense' do
        expect_no_offenses(<<-RUBY)
          execute 'rm -rf /tmp/*'
        RUBY
      end
    end

    context 'with command param' do
      it 'registers no offense' do
        expect_no_offenses(<<-RUBY)
          execute 'Remove temporary files' do
            command 'rm -rf /tmp/*'
          end
        RUBY
      end
    end
  end
end
