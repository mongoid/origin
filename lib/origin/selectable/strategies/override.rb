# encoding: utf-8
module Origin
  module Selectable
    module Strategies
      module Override

        # Instruct the next queryable call to use override.
        #
        # @example Use override on the next call.
        #   queryable.override.in(field: [ 1, 2, 3 ])
        #
        # @return [ Queryable ] The override flagged queryable.
        #
        # @since 1.0.0
        def override
          tap { |query| query.strategy = :__override__ }
        end

        # Adds the criterion to the existing selection.
        #
        # @example Add the criterion.
        #   queryable.__override__([ 1, 2 ], "$in")
        #
        # @param [ Hash ] criterion The criteria.
        # @param [ String ] operator The MongoDB operator.
        #
        # @return [ Queryable ] The new queryable.
        #
        # @since 1.0.0
        def __override__(criterion, operator)
          selection(criterion) do |selector, field, value|
            selector.store(field, { operator => value })
          end
        end
      end
    end
  end
end
