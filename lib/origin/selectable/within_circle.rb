# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $within/$center selection.
    module WithinCircle

      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def within_circle(criterion = nil)
        __expanded__(criterion, "$within", "$center")
      end

      # Add the key to symbol for where matching.
      #
      # @example Execute an $within/$center in a where query.
      #   queryable.where(:field.within_circle => [[ 1, 10 ], 25 ])
      #
      # @since 1.0.0
      ::Symbol.add_multi_key(:within_circle, "$within", "$center")
    end
  end
end
