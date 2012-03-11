# encoding: utf-8
module Origin
  module Selectable
    module Strategies
      module Multi

        private

        # Adds the criterion to the existing selection.
        #
        # @api private
        #
        # @example Add the criterion.
        #   queryable.__multi__([ 1, 2 ], "$in")
        #
        # @param [ Hash ] criterion The criteria.
        # @param [ String ] operator The MongoDB operator.
        #
        # @return [ Queryable ] The new queryable.
        #
        # @since 1.0.0
        def __multi__(criterion, operator)
          clone.tap do |query|
            sel = query.selector
            criterion.each do |expr|
              next unless expr
              criteria = sel[operator] || []
              sel.store(operator, criteria.push(expr))
            end
          end
        end
      end
    end
  end
end
