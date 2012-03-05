# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $maxDistance selection.
    module MaxDistance

      # Add a $maxDistance selection to the queryable.
      #
      # @example Add the $maxDistance selection.
      #   queryable.max_distance(location: 10)
      #
      # @param [ Hash ] criterion The field/distance pairs.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def max_distance(criterion = nil)
        __add__(criterion, "$maxDistance")
      end
    end
  end
end
