# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $nin selection.
    module Nin

      # Adds the $nin selection to the queryable.
      #
      # @example Add $nin selection on an array.
      #   queryable.nin(age: [ 1, 2, 3 ])
      #
      # @example Add $nin selection on a range.
      #   queryable.nin(age: 18..24)
      #
      # @example Execute an $nin in a where query.
      #   queryable.where(:field.nin => [ 1, 2, 3 ])
      #
      # @param [ Hash ] criterion The field/value criterion pairs.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def nin(criterion = nil)
        send(strategy || :__intersect__, with_array_values(criterion), "$nin")
      end
      alias :not_in :nin

      ::Symbol.add_key(:nin, "$nin")
    end
  end
end
