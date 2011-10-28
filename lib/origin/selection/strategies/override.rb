# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Override

        def override
          tap { |query| query.strategy = :_override }
        end

        def _override(criterion, operator)
          assimilate(criterion) do |selector, field, value|
            selector.store(field, { operator => value })
          end
        end
      end
    end
  end
end
