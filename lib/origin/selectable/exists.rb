# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $exists selection.
    module Exists

      # Add the $exists selection.
      #
      # @example Add a single selection.
      #   queryable.exists(field: true)
      #
      # @example Add multiple selections.
      #   queryable.exists(field: true, other: false)
      #
      # @param [ Hash ] criterion The field/boolean existence checks.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def exists(criterion = nil)
        __override__(criterion, "$exists")
      end

      # Add the key to symbol for where matching.
      #
      # @example Execute an $exists in a where query.
      #   queryable.where(:field.exists => true)
      #
      # @since 1.0.0
      ::Symbol.add_key(:exists, "$exists")
    end
  end
end
