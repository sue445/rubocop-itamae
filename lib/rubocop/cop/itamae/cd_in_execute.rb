# frozen_string_literal: true

module RuboCop
  module Cop
    module Itamae
      # Check that `cd` in `execute`.
      #
      # @example
      #   # bad
      #   execute 'cd /tmp && rm -rf /tmp/*'
      #
      #   # good
      #   execute 'rm -rf /tmp/*' do
      #     cwd '/tmp'
      #   end
      class CdInExecute < Cop
        MSG = "Insert `cwd '%<dir>s'` and remove this."

        def_node_search :find_execute_with_block, <<-PATTERN
          (block
            (send nil? :execute
              (str $_)
            )
            args
            $...
          )
        PATTERN

        def_node_search :find_execute_without_block, <<-PATTERN
          (send nil? :execute
            (str $_)
          )
        PATTERN

        def_node_search :find_command, <<-PATTERN
          (send nil? :command
            (str $_)
          )
        PATTERN

        def on_block(node)
          find_execute_with_block(node) do |name, param_nodes|
            add_offence_for_execute_block_name(node, name)

            param_nodes.compact.each do |param_node|
              find_command(param_node) do |command|
                add_offense_for_command_param(param_node, command)
              end
            end
          end
        end

        def on_send(node)
          return if node.parent&.block_type?

          find_execute_without_block(node) do |name|
            add_offense_for_execute_name(node, name)
          end
        end

        # rubocop:disable Metrics/LineLength
        # def autocorrect(node)
        #   if node.block_type?
        #     lambda do |corrector|
        #       find_execute_with_block(node) do |name, param_nodes|
        #         if offence_command?(name)
        #           corrector.remove(cd_location(node.child_nodes.first.child_nodes.first, name))
        #
        #           # TODO: insert cwd
        #           next
        #         end
        #       end
        #     end
        #   elsif node.begin_type?
        #     lambda do |corrector|
        #       find_command(node) do |command|
        #         next unless offence_command?(command)
        #
        #         command_node = node.child_nodes.first.child_nodes.first
        #         corrector.remove(cd_location(command_node, command))
        #
        #         # TODO: insert cwd
        #       end
        #     end
        #   elsif node.send_type?
        #     lambda do |corrector|
        #       find_execute_without_block(node) do |name|
        #         next unless offence_command?(name)
        #
        #         corrector.remove(cd_location(node.child_nodes.first, name))
        #
        #         # TODO: insert cwd
        #       end
        #
        #       find_command(node) do |command|
        #         next unless offence_command?(command)
        #
        #         command_node = node.child_nodes.first
        #         corrector.remove(cd_location(command_node, command))
        #
        #         # TODO: insert cwd
        #       end
        #     end
        #   end
        # end
        # rubocop:enable Metrics/LineLength

        private

        def add_offense_for_execute_name(node, name)
          dir = cd_dir_in_command(name)
          return unless dir

          loc = cd_location(node.child_nodes.first, name)
          add_offense(node, message: format(MSG, dir: dir), location: loc)
        end

        def add_offence_for_execute_block_name(node, name)
          dir = cd_dir_in_command(name)
          return unless dir

          loc = cd_location(node.child_nodes.first.child_nodes.first, name)
          add_offense(node, message: format(MSG, dir: dir), location: loc)
        end

        def add_offense_for_command_param(param_node, command)
          dir = cd_dir_in_command(command)
          return unless dir

          command_node =
            if param_node.child_nodes.first.child_nodes.empty?
              param_node.child_nodes.first
            else
              param_node.child_nodes.first.child_nodes.first
            end

          loc = cd_location(command_node, command)
          add_offense(param_node, message: format(MSG, dir: dir), location: loc)
        end

        def cd_dir_in_command(command)
          dir, = parse_command(command)
          dir
        end

        def parse_command(command)
          command =~ /^\s*cd\s+(.+?)&&(.+)$/
          if Regexp.last_match(1) && Regexp.last_match(2)
            [Regexp.last_match(1).strip, Regexp.last_match(2).strip]
          else
            [nil, nil]
          end
        end

        def cd_location(node, command)
          _, second_command = parse_command(command)
          second_command_pos = command.index(second_command)
          begin_pos = node.loc.begin.end_pos
          end_pos = begin_pos + second_command_pos
          Parser::Source::Range.new(node.loc.expression.source_buffer,
                                    begin_pos, end_pos)
        end

        # def indent_num(node)
        #   node.loc.expression.source_buffer.source =~ /^(\s+)/
        #
        #   return Regexp.last_match(1).length if Regexp.last_match(1)
        #   0
        # end
      end
    end
  end
end
