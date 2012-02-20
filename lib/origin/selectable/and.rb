# encoding: utf-8
module Origin
  module Selectable
    module And

      def and(*criterion)
        __multi__(criterion, "$and")
      end
      alias :all_of :and
    end
  end
end
