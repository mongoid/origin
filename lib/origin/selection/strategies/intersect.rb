# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Intersect

        def intersect
          tap { |query| query.strategy = :_intersect }
        end

        def _intersect(criterion, operator)
          assimilate(criterion) do |selector, field, value|
            selector.store(
              field,
              selector[field]._intersect({ operator => value })
            )
          end
        end
      end
    end
  end
end
