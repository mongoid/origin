# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $within/$center selection.
    module WithinCircle

      # Adds the $within/$center selection to the queryable.
      #
      # @example Add the selection.
      #   queryable.within_circle(location: [[ 1, 10 ], 25 ])
      #
      # @example Execute an $within/$center in a where query.
      #   queryable.where(:field.within_circle => [[ 1, 10 ], 25 ])
      #
      # @param [ Hash ] criterion The field/radius criterion.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def within_circle(criterion = nil)
        __expanded__(criterion, "$within", "$center")
      end

      ::Symbol.add_multi_key(:within_circle, "$within", "$center")
    end
  end
end
