# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Intersect

        def intersect
          tap { |query| query.strategy = :intersect! }
        end

        private

        def intersect!(criterion, operator)
          assimilate(criterion) do |query, field, value|
            selector = query.selector
            existing = selector[field]
            selection = existing ? existing[operator] & value : value
            selector.store(field, { operator => selection })
          end
        end
      end
    end
  end
end
