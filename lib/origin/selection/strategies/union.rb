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
            query.selector.union!(field, operator, value)
          end
        end
      end
    end
  end
end
