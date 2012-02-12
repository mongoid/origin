# encoding: utf-8
module Origin
  module Selectable
    module ElemMatch

      def elem_match(criterion = nil)
        __override__(criterion, "$elemMatch")
      end

      ::Symbol.add_key(:elem_match, "$elemMatch")
    end
  end
end
