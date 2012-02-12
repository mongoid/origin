# encoding: utf-8
module Origin
  module Selectable
    module Strategies
      module Union

        def union
          tap { |query| query.strategy = :__union__ }
        end

        def __union__(criterion, operator)
          with_strategy(:__union__, criterion, operator)
        end
      end
    end
  end
end
