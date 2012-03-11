# encoding: utf-8
module Origin
  module Selectable
    module Strategies
      module Union

        # Instruct the next queryable call to use union.
        #
        # @example Use union on the next call.
        #   queryable.union.in(field: [ 1, 2, 3 ])
        #
        # @return [ Queryable ] The union flagged queryable.
        #
        # @since 1.0.0
        def union
          tap { |query| query.strategy = :__union__ }
        end

        # Adds the criterion to the existing selection.
        #
        # @example Add the criterion.
        #   queryable.__union__([ 1, 2 ], "$in")
        #
        # @param [ Hash ] criterion The criteria.
        # @param [ String ] operator The MongoDB operator.
        #
        # @return [ Queryable ] The new queryable.
        #
        # @since 1.0.0
        def __union__(criterion, operator)
          with_strategy(:__union__, criterion, operator)
        end
      end
    end
  end
end
