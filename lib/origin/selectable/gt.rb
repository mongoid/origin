# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $gt selection.
    module Gt

      # Add the $gt criterion to the selector.
      #
      # @example Add the $gt criterion.
      #   queryable.gt(age: 60)
      #
      # @param [ Hash ] criterion The field/value pairs to check.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def gt(criterion = nil)
        __override__(criterion, "$gt")
      end

      # Add the key to symbol for where matching.
      #
      # @example Execute an $gt in a where query.
      #   queryable.where(:field.gt => 10)
      #
      # @since 1.0.0
      ::Symbol.add_key(:gt, "$gt")
    end
  end
end
