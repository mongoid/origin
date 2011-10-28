# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Union

        def union
          tap { |query| query.strategy = :_union }
        end

        def _union(criterion, operator)
          assimilate(criterion) do |selector, field, value|
            selector.store(
              field,
              selector[field]._union({ operator => value })
            )
          end
        end
      end
    end
  end
end
