# frozen_string_literal: true

module RuboCop
  module Cop
    module Itamae
      # Checks whether the recipe is placed under `cookbooks` dir
      # or `roles` dir.
      #
      # @see https://github.com/itamae-kitchen/itamae/wiki/Best-Practice#directory-structure
      #
      # @example
      #   # bad
      #   default.rb
      #   hoge/web.rb
      #
      #   # good
      #   cookbooks/nginx/default.rb
      #   roles/web.rb
      #
      class RecipePath < Base
        include RangeHelp

        MSG = 'Prefer recipe to placed under `cookbooks` dir or `roles` dir.'

        def on_new_investigation
          file_path = processed_source.file_path
          return if config.file_to_include?(file_path)

          add_global_offense if bad_filename?(file_path)
        end

        private

        def bad_filename?(file_path)
          return false unless File.extname(file_path) == '.rb'

          !file_path.match?(%r{/(cookbooks|roles)/})
        end
      end
    end
  end
end
