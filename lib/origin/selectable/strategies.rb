# encoding: utf-8
require_all __FILE__, "strategies"

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
