# frozen_string_literal: true

module RuboCop
  module Cop
    module Itamae
      # Checks whether default action is written for resource.
      #
      # @example
      #   # bad
      #   package 'git' do
      #     action :install
      #   end
      #
      #   # good
      #   package 'git' do
      #   end
      #
      #   package 'git'
      #
      class NeedlessDefaultAction < Cop
        include RangeHelp

        MSG = 'Prefer to omit the default action.'.freeze

        RESOURCE_DEFAULT_ACTIONS = {
          directory:        :create,
          execute:          :run,
          file:             :create,
          gem_package:      :install,
          git:              :sync,
          group:            :create,
          http_request:     :create,
          link:             :create,
          local_ruby_block: :run,
          package:          :install,
          remote_directory: :create,
          remote_file:      :create,
          service:          :nothing,
          template:         :create,
          user:             :create
        }.freeze

        def_node_search :find_resource, <<-PATTERN
          (block
            (send nil? ${:directory :execute :file :gem_package :git :group :http_request :link :local_ruby_block :package :remote_directory :remote_file :service :template :user}
              (...)
            )
            args
            $...
          )
        PATTERN

        def_node_search :find_action, <<-PATTERN
          (send nil? :action
            (sym $_)
          )
        PATTERN

        def on_block(node)
          find_resource(node) do |resource, param_nodes|
            param_nodes.compact.each do |param_node|
              find_action(param_node) do |action|
                next unless action == RESOURCE_DEFAULT_ACTIONS[resource]

                add_offense(param_node, location: :expression)
              end
            end
          end
        end

        def autocorrect(node)
          lambda do |corrector|
            remove_action_param(corrector, node.parent, node) if node.send_type?
          end
        end

        private

        def remove_action_param(corrector, parent_node, param_node)
          find_resource(parent_node) do |resource|
            find_action(param_node) do |action|
              next unless action == RESOURCE_DEFAULT_ACTIONS[resource]

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
