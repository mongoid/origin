# encoding: utf-8
module Origin
  module Selection
    module ElemMatch

      def elem_match(criterion = nil)
        _override(criterion, "$elemMatch")
      end

      ::Symbol.class_eval do

        def elem_match
          Key.new(self, "$elemMatch")
        end
      end
    end
  end
end
