# encoding: utf-8
module Origin
  module Selectable
    module Or

      def or(*criterion)
        __multi__(criterion, "$or")
      end
      alias :any_of :or
    end
  end
end
