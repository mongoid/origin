# encoding: utf-8
module Origin
  module Selectable
    module Strategies
      module Union

        def union
          tap { |query| query.strategy = :__union__ }
        end

        def __union__(criterion, operator)
          selection(criterion) do |selector, field, value|
            selector.store(
              field,
              selector[field].__union__({ operator => value })
            )
          end
        end
      end
    end
  end
end
