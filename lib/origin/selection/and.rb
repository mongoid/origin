# encoding: utf-8
module Origin
  module Selection
    module And

      def and(*criterion)
        __multi__(criterion, "$and")
      end
    end
  end
end
