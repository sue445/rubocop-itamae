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
      class RecipePath < Cop
        include RangeHelp

        MSG = 'Prefer recipe to placed under `cookbooks` dir' \
              ' or `roles` dir.'

        def investigate(processed_source)
          file_path = processed_source.file_path
          return if config.file_to_include?(file_path)

          for_bad_filename(file_path) do |range, msg|
            add_offense(nil, location: range, message: msg)
          end
        end

        private

        def for_bad_filename(file_path)
          return unless File.extname(file_path) == '.rb'
          return if file_path =~ %r{/(cookbooks|roles)/}

          yield source_range(processed_source.buffer, 1, 0), MSG
        end
      end
    end
  end
end
