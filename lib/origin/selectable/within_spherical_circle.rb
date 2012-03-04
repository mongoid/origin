# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $within/$centerSphere selection.
    module WithinSphericalCircle

      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def within_spherical_circle(criterion = nil)
        __expanded__(criterion, "$within", "$centerSphere")
      end

      # Add the key to symbol for where matching.
      #
      # @example Execute an $within/$centerSphere in a where query.
      #   queryable.where(:field.within_spherical_circle => [[ 1, 10 ], 25 ])
      #
      # @since 1.0.0
      ::Symbol.add_multi_key(:within_spherical_circle, "$within", "$centerSphere")
    end
  end
end
