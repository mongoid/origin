# encoding: utf-8
module Origin
  module Selectable
    module And

      def and(*criterion)
        __multi__(criterion, "$and")
      end
    end
  end
end
