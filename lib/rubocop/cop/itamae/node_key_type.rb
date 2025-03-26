# frozen_string_literal: true

module RuboCop
  module Cop
    module Itamae
      # Check for node key type.
      #
      # @example EnforcedStyle: symbol (default)
      #
      #   # bad
      #   node['ruby']['version']
      #
      #   # good
      #   node[:ruby][:version]
      #
      #   # good
      #   node['td-agent'][:version]
      #
      # @example EnforcedStyle: string
      #   # bad
      #   node[:ruby][:version]
      #
      #   # good
      #   node['ruby']['version']
      #
      class NodeKeyType < Cop
        def on_index(node)
        end
      end
    end
  end
end
