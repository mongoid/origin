# encoding: utf-8
module Origin
  module Selection
    module And

      def and(*criterion)
        multi!(criterion, "$and")
      end
    end
  end
end
