# encoding: utf-8
module Origin
  module Selection
    module And

      def and(*criterion)
        clone.tap do |query|
          sel = query.selector
          criterion.each do |expr|
            next unless expr
            sel.fetch("$and"){ |key| sel.store("$and", []) }.push(expr)
          end
        end
      end
    end
  end
end
