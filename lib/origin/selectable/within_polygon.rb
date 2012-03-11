# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $within/$polygon selection.
    module WithinPolygon

      # Adds the $within/$polygon selection to the queryable.
      #
      # @example Add the selection.
      #   queryable.within_polygon(
      #     location: [[ 10, 20 ], [ 10, 40 ], [ 30, 40 ], [ 30, 20 ]]
      #   )
      #
      # @example Execute an $within/$polygon in a where query.
      #   queryable.where(
      #     :field.within_polygon => [[ 10, 20 ], [ 10, 40 ], [ 30, 40 ], [ 30, 20 ]]
      #   )
      #
      # @param [ Hash ] criterion The field/polygon points criterion.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def within_polygon(criterion = nil)
        __expanded__(criterion, "$within", "$polygon")
      end

      ::Symbol.add_multi_key(:within_polygon, "$within", "$polygon")
    end
  end
end
