# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $in selection.
    module In

      # Adds the $in selection to the queryable.
      #
      # @example Add $in selection on an array.
      #   queryable.in(age: [ 1, 2, 3 ])
      #
      # @example Add $in selection on a range.
      #   queryable.in(age: 18..24)
      #
      # @param [ Hash ] criterion The field/value criterion pairs.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def in(criterion = nil)
        send(strategy || :__intersect__, with_array_values(criterion), "$in")
      end
      alias :any_in :in

      # Add the key to symbol for where matching.
      #
      # @example Execute an $in in a where query.
      #   queryable.where(:field.in => [ 1, 2, 3 ])
      #
      # @since 1.0.0
      ::Symbol.add_key(:in, "$in")
    end
  end
end
