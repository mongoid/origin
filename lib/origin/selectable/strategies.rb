# encoding: utf-8
require "origin/selectable/strategies/add"
require "origin/selectable/strategies/expanded"
require "origin/selectable/strategies/intersect"
require "origin/selectable/strategies/multi"
require "origin/selectable/strategies/override"
require "origin/selectable/strategies/union"

module Origin
  module Selectable
    module Strategies
      include Add
      include Expanded
      include Intersect
      include Multi
      include Override
      include Union

      attr_accessor :strategy

      def with_strategy(strategy, criterion, operator)
        selection(criterion) do |selector, field, value|
          selector.store(
            field,
            selector[field].send(strategy, { operator => value })
          )
        end
      end
    end
  end
end
