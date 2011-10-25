# encoding: utf-8
module Origin
  module Selection
    module Or

      def or(*criterion)
        clone.tap do |query|
          sel = query.selector
          criterion.each do |expr|
            next unless expr
            sel.fetch("$or"){ |key| sel.store("$or", []) }.push(expr)
          end
        end
      end
    end
  end
end
