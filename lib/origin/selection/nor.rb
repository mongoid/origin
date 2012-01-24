# encoding: utf-8
module Origin
  module Selection
    module Nor

      def nor(*criterion)
        __multi__(criterion, "$nor")
      end
    end
  end
end
