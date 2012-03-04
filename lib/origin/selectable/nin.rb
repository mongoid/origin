# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $nin selection.
    module Nin

      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def nin(criterion = nil)
        send(strategy || :__intersect__, criterion, "$nin")
      end
      alias :not_in :nin

      # Add the key to symbol for where matching.
      #
      # @example Execute an $nin in a where query.
      #   queryable.where(:field.nin => [ 1, 2, 3 ])
      #
      # @since 1.0.0
      ::Symbol.add_key(:nin, "$nin")
    end
  end
end
