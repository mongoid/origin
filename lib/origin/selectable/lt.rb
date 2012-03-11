# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $lt selection.
    module Lt

      # Add the $lt criterion to the selector.
      #
      # @example Add the $lt criterion.
      #   queryable.lt(age: 60)
      #
      # @example Execute an $lt in a where query.
      #   queryable.where(:field.lt => 10)
      #
      # @param [ Hash ] criterion The field/value pairs to check.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def lt(criterion = nil)
        __override__(criterion, "$lt")
      end

      ::Symbol.add_key(:lt, "$lt")
    end
  end
end
