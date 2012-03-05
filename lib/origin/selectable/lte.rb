# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $lte selection.
    module Lte

      # Add the $lte criterion to the selector.
      #
      # @example Add the $lte criterion.
      #   queryable.lte(age: 60)
      #
      # @param [ Hash ] criterion The field/value pairs to check.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def lte(criterion = nil)
        __override__(criterion, "$lte")
      end

      # Add the key to symbol for where matching.
      #
      # @example Execute an $lte in a where query.
      #   queryable.where(:field.lte => 10)
      #
      # @since 1.0.0
      ::Symbol.add_key(:lte, "$lte")
    end
  end
end
