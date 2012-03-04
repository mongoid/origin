# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $within/$polygon selection.
    module WithinPolygon

      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def within_polygon(criterion = nil)
        __expanded__(criterion, "$within", "$polygon")
      end

      # Add the key to symbol for where matching.
      #
      # @example Execute an $within/$polygon in a where query.
      #   queryable.where(
      #     :field.within_polygon => [[ 10, 20 ], [ 10, 40 ], [ 30, 40 ], [ 30, 20 ]]
      #   )
      #
      # @since 1.0.0
      ::Symbol.add_multi_key(:within_polygon, "$within", "$polygon")
    end
  end
end
