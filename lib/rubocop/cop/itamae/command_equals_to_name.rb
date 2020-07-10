# frozen_string_literal: true

module RuboCop
  module Cop
    module Itamae
      # Check that `command` doesn't equals to name of `execute`.
      #
      # @example
      #   # bad
      #   execute 'rm -rf /tmp/*' do
      #     command 'rm -rf /tmp/*'
      #   end
      #
      #   # good
      #   execute 'rm -rf /tmp/*'
      #
      #   execute 'Remove temporary files' do
      #     command 'rm -rf /tmp/*'
      #   end
      class CommandEqualsToName < Base
        include RangeHelp
        extend AutoCorrector

        MSG = 'Prefer to omit `command` if `command` equals to ' \
              'name of `execute`'

        def_node_search :find_execute, <<-PATTERN
          (block
            (send nil? :execute
              (str $_)
            )
            args
            $...
          )
        PATTERN

        def_node_search :find_command, <<-PATTERN
          (send nil? :command
            (str $_)
          )
        PATTERN

        def on_block(node)
          find_execute(node) do |name, param_nodes|
            param_nodes.compact.each do |param_node|
              find_command(param_node) do |command|
                next unless name == command

                add_param_node_offense(param_node)
              end
            end
          end
        end

        private

        def add_param_node_offense(param_node)
          add_offense(param_node.loc.expression) do |corrector|
            if param_node.begin_type?
              param_node.each_child_node do |child_param_node|
                remove_command_param(corrector, param_node.parent, child_param_node)
              end

            elsif param_node.send_type?
              remove_command_param(corrector, param_node.parent, param_node)
            end
          end
        end

        def remove_command_param(corrector, parent_node, param_node)
          find_execute(parent_node) do |name|
            find_command(param_node) do |command|
              next unless name == command

              corrector.remove(node_range(param_node))
            end
          end
        end

        def node_range(node)
          range_by_whole_lines(node.source_range, include_final_newline: true)
        end
      end
    end
  end
end
