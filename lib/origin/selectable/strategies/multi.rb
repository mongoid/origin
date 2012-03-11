# encoding: utf-8
module Origin
  module Selectable
    module Strategies
      module Multi

        private

        def __multi__(criterion, operator)
          clone.tap do |query|
            sel = query.selector
            criterion.each do |expr|
              next unless expr
              criteria = sel[operator] || []
              sel.store(operator, criteria.push(expr))
            end
          end
        end
      end
    end
  end
end
