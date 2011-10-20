# encoding: utf-8
module Origin
  module Selection
    module ElemMatch

      def elem_match(criterion = nil)
        clone.tap do |query|
          if criterion
            criterion.each_pair do |field, expr|
              query.selector.store(field, "$elemMatch" => expr)
            end
          end
        end
      end

      ::Symbol.class_eval do

        def elem_match
          Key.new(self.to_s, "$elemMatch")
        end
      end
    end
  end
end
