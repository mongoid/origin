# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Intersect

        def intersect
          tap { |query| query.strategy = :__intersect__ }
        end

        def __intersect__(criterion, operator)
          selection(criterion) do |selector, field, value|
            selector.store(
              field,
              selector[field].__intersect__({ operator => value })
            )
          end
        end
      end
    end
  end
end
