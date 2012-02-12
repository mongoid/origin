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

      def selection(criterion = nil)
        clone.tap do |query|
          if criterion
            criterion.each_pair do |field, value|
              yield(query.selector, field, value)
            end
          end
        end
      end

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
