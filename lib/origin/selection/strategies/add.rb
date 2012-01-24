# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Add

        def __add__(criterion, operator)
          selection(criterion) do |selector, field, value|
            selector.store(
              field,
              selector[field].__add__({ operator => value })
            )
          end
        end
      end
    end
  end
end
