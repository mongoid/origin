# encoding: utf-8
require "origin/selectable/strategies/add"
require "origin/selectable/strategies/expanded"
require "origin/selectable/strategies/intersect"
require "origin/selectable/strategies/multi"
require "origin/selectable/strategies/override"
require "origin/selectable/strategies/union"

module Origin
  module Selectable

    # This module adds behaviour for different types of merge strategies when
    # generating selection.
    module Strategies
      include Add
      include Expanded
      include Intersect
      include Multi
      include Override
      include Union

      # @attribute [rw] strategy The name of the current strategy.
      attr_accessor :strategy

      # Add criterion to the selection with the named strategy.
      #
      # @example Add criterion with a strategy.
      #   selectable.with_strategy(:__union__, [ 1, 2, 3 ], "$in")
      #
      # @param [ Symbol ] strategy The name of the strategy method.
      # @param [ Object ] criterion The criterion to add.
      # @param [ String ] operator The MongoDB operator.
      #
      # @return [ Queryable ] The cloned query.
      #
      # @since 1.0.0
      def with_strategy(strategy, criterion, operator)
        selection(criterion) do |selector, field, value|
          selector.store(
            field,
            selector[field].send(strategy, { operator => prepare(field, value) })
          )
        end
      end

      private

      def prepare(field, value)
        serializer = serializers[field]
        serializer ? serializer.evolve(value) : value
      end
    end
  end
end
