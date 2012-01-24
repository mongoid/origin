# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Multi

        private

        def __multi__(criterion, operator)
          clone.tap do |query|
            sel = query.selector
            criterion.each do |expr|
              next unless expr
              sel.fetch(operator){ |key| sel.store(operator, []) }.push(expr)
            end
          end
        end
      end
    end
  end
end
