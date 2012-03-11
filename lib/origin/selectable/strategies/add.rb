# encoding: utf-8
module Origin
  module Selectable
    module Strategies

      # This module provides the addition strategy behaviour.
      module Add

        # Adds the criterion to the existing selection.
        #
        # @example Add the criterion.
        #   queryable.__add__({ name: 1 }, "$in")
        #
        # @param [ Hash ] criterion The criteria.
        # @param [ String ] operator The MongoDB operator.
        #
        # @return [ Queryable ] The new queryable.
        #
        # @since 1.0.0
        def __add__(criterion, operator)
          with_strategy(:__add__, criterion, operator)
        end
      end
    end
  end
end
