# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $maxDistance selection.
    module MaxDistance

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
