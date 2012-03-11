# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $within/$centerSphere selection.
    module WithinSphericalCircle

      # Adds the $within/$centerSphere selection to the queryable.
      #
      # @example Add the selection.
      #   queryable.within_spherical_circle(location: [[ 1, 10 ], 25 ])
      #
      # @example Execute an $within/$centerSphere in a where query.
      #   queryable.where(:field.within_spherical_circle => [[ 1, 10 ], 25 ])
      #
      # @param [ Hash ] criterion The field/distance criterion.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def within_spherical_circle(criterion = nil)
        __expanded__(criterion, "$within", "$centerSphere")
      end

      ::Symbol.add_multi_key(:within_spherical_circle, "$within", "$centerSphere")
    end
  end
end
