# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $nearSphere selection.
    module NearSphere

      # Adds a $nearSphere criterion to a geo selection.
      #
      # @example Add the $nearSphere selection.
      #   queryable.near_sphere(location: [ 23.1, 12.1 ])
      #
      # @param [ Hash ] criterion The field/location pair.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def near_sphere(criterion = nil)
        __override__(criterion, "$nearSphere")
      end

      # Add the key to symbol for where matching.
      #
      # @example Execute an $nearSphere in a where query.
      #   queryable.where(:field.near_sphere => [ 10.11, 3.22 ])
      #
      # @since 1.0.0
      ::Symbol.add_key(:near_sphere, "$nearSphere")
    end
  end
end
