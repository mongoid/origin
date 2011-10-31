# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Add

        def _add(criterion, operator)
          selection(criterion) do |selector, field, value|
            selector.store(
              field,
              selector[field]._add({ operator => value })
            )
          end
        end
      end
    end
  end
end
