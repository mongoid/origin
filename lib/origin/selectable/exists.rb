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
      # @example Execute an $exists in a where query.
      #   queryable.where(:field.exists => true)
      #
      # @param [ Hash ] criterion The field/boolean existence checks.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def exists(criterion = nil)
        __override__(criterion, "$exists")
      end

      ::Symbol.add_key(:exists, "$exists")
    end
  end
end
