# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Override

        def override(criterion, operator)
          assimilate(criterion) do |query, field, value|
            query.selector.store(field, { operator => value })
          end
        end
      end
    end
  end
end
