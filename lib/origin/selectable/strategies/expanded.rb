# encoding: utf-8
module Origin
  module Selectable
    module Strategies

      # This module contains the expanded (multi operator) behaviour.
      module Expanded

        # Adds the criterion to the existing selection.
        #
        # @example Add the criterion.
        #   queryable.__expanded__([ 1, 10 ], "$within", "$center")
        #
        # @param [ Hash ] criterion The criteria.
        # @param [ String ] outer The outer MongoDB operator.
        # @param [ String ] inner The inner MongoDB operator.
        #
        # @return [ Queryable ] The new queryable.
        #
        # @since 1.0.0
        def __expanded__(criterion, outer, inner)
          selection(criterion) do |selector, field, value|
            selector.store(field, { outer => { inner => value }})
          end
        end
      end
    end
  end
end
