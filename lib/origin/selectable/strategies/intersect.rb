# encoding: utf-8
module Origin
  module Selectable
    module Strategies

      # This module contains intersection behaviour.
      module Intersect

        # Instruct the next queryable call to use intersection.
        #
        # @example Use intersection on the next call.
        #   queryable.intersect.in(field: [ 1, 2, 3 ])
        #
        # @return [ Queryable ] The intersect flagged queryable.
        #
        # @since 1.0.0
        def intersect
          tap { |query| query.strategy = :__intersect__ }
        end

        # Adds the criterion to the existing selection.
        #
        # @example Add the criterion.
        #   queryable.__intersect__([ 1, 2 ], "$in")
        #
        # @param [ Hash ] criterion The criteria.
        # @param [ String ] operator The MongoDB operator.
        #
        # @return [ Queryable ] The new queryable.
        #
        # @since 1.0.0
        def __intersect__(criterion, operator)
          with_strategy(:__intersect__, criterion, operator)
        end
      end
    end
  end
end
