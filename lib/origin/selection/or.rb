# encoding: utf-8
module Origin
  module Selection
    module Or

      def or(*criterion)
        __multi__(criterion, "$or")
      end
    end
  end
end
