# encoding: utf-8
module Origin
  module Selection
    module Nor

      def nor(*criterion)
        multi!(criterion, "$nor")
      end
    end
  end
end
