# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Union

        def union
          tap { |query| query.strategy = :union! }
        end

        private

        def union!(criterion, operator)
          assimilate(criterion) do |query, field, value|
            selector = query.selector
            existing = selector[field]
            selection = existing ? existing[operator] + value : value
            selector.store(field, { operator => selection })
          end
        end
      end
    end
  end
end
